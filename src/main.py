# This Python file uses the following encoding: utf-8
import sys
import yaml
import os
import json

import shutil
import tempfile

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

from wordcloud import WordCloud
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Signal, Slot, QSettings

from coslab import tag_comparator, taggerresults

class AnalyseImages(QObject):
    def __init__(self):
        super().__init__()
        self._results = None
        self._services = {}
        self._wordclouds = []
        self._scores = np.zeros((4,4))
        self._config = QSettings('UH-DCM', 'coslab-gui')

    resultChanged = Signal(list)
    wordcloudGenerated = Signal(list)
    scoresGenerated = Signal(list)
    getScore = Signal(str)
    statusUpdated = Signal(str) # Currently not useful, QML does not repaint

    @Slot(list, list)
    def analyse_images(self, url_list, checkboxes):
        results = taggerresults.TaggerResults()
        services = {}
        # Setting up the services with coslab-core
        if checkboxes[0]:
            self.statusUpdated.emit("Loading Google Vision...")
            global googlecloud
            from coslab import googlecloud
            google = googlecloud.GoogleCloud( json.loads(self._config.value("google_service_account_info")) )
            services['google'] = google
        if checkboxes[1]:
            # ToDo: configure IBM
            pass
        if checkboxes[2]:
            self.statusUpdated.emit("Loading Azure Vision...")
            global azure_vision
            from coslab import azure_vision
            azure = azure_vision.Azure(
                self._config.value("azure_azure_subscription_key") ,
                self._config.value("azure_endpoint")
            )
            services['azure'] = azure
        if checkboxes[3]:
            self.statusUpdated.emit("Loading Amazon Web Service...")
            global aws
            from coslab import aws
            amazon = aws.AWS(
                self._config.value("aws_api_id") ,
                self._config.value("aws_api_key"),
                self._config.value("aws_api_region")
            )
            services['aws'] = amazon
        # Processing data
        for service in services:
            for url in url_list:
                services[service].process_local(results, url)

        self._services = services
        self._results = results
        self.resultChanged.emit(self._results)

    @Slot()
    def generate_wordcloud(self):
        self._wordclouds.clear() ## empty results first
        wordlistAll = []
        # Iterating through selected services
        for service in self._services:
            wordlist = []
            # Iterating through labels
            for image in self._results.labels:
                for label in self._results.labels[image][service]:
                    wordlist.append(label['label'])
                    wordlistAll.append(label['label'])
            # Generating individual service wordcloud 
            wc = WordCloud( background_color = "white" ).generate(' '.join(wordlist))
            
            plt.clf()
            plt.imshow( wc, interpolation='bilinear')
            plt.axis( "off" )
            plt.title( service )

            tmp = tempfile.NamedTemporaryFile(suffix='.png', delete=False)  ## TODO: Check if delete=False is good here
            plt.savefig( tmp.name, bbox_inches='tight' )
            self._wordclouds.append( tmp.name )
        # Generating all services wordcloud
       
        wc = WordCloud( background_color = "white" ).generate(' '.join(wordlistAll))

        plt.clf()
        plt.imshow( wc, interpolation='bilinear')
        plt.axis( "off" )
        plt.title( "All services" )

        tmp = tempfile.NamedTemporaryFile(suffix='.png', delete=False) ## TODO: Check if delete=False is good here
        plt.savefig( tmp.name, bbox_inches='tight' )
        self._wordclouds.append( tmp.name )
        # Sending signal to QML with generated files
        qt_urls = [("file://" + path) for path in self._wordclouds]
        self.wordcloudGenerated.emit(qt_urls)

    @Slot()
    def generate_scores(self):
        all_services = ['aws', 'azure', 'google']
        scoresString = [ [ "0" for i in range(5) ] for j in range(4) ]
        for i, service in enumerate(all_services):
            for j, other_service in enumerate(all_services):
                if service in self._services and other_service in self._services:
                    compared = tag_comparator.compare_tags(self._results, service, other_service, tag_comparator.glove_comparator)
                    self._scores[i][j] = sum([value[0] for value in compared.values()])
                    scoresString[i][j] = "{:.2f}".format(self._scores[i][j])
        self.scoresGenerated.emit(scoresString)

    @Slot(bool, bool, bool, bool, bool, bool, str)
    def export(self, wc, comp, comma, pickl, js, excel, location):
        location = location.replace('file://', '')
        # Word cloud export
        if wc:
            for number, file in enumerate( self._wordclouds ):
                shutil.copy( file, f"{location}/wordcloud-{number+1}.png" )
        # Comparison table export
        if comp:
            pass ## TODO: add comparsion table export
        # CSV export
        if comma:
            self._results.export_csv( f"{location}/results.csv", comparator = tag_comparator.glove_comparator  )
        # Pickle export
        if pickl:
            self._results.export_pickle( f"{location}/results.pickle")
        # JSON export
        if js:
            pass ## TODO: add JSON export to the library
        # Excel export
        if excel:
            self._results.to_pandas( comparator = tag_comparator.glove_comparator ).to_excel( f"{location}/results.xlsx" )

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    app.setOrganizationName('UH-DCM')
    app.setApplicationName('coslab-gui')

    analyst = AnalyseImages()

    engine.rootContext().setContextProperty("backend", analyst)

    qml_file = Path(__file__).resolve().parent / "ui/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
