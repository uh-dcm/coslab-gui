# This Python file uses the following encoding: utf-8
import sys
import yaml
import os

import matplotlib.pyplot as plt
import numpy as np

from wordcloud import WordCloud
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Signal, Slot, QThread


class AnalyseImages(QObject):
    def __init__(self):
        super().__init__()
        self._results = None
        self._services = {}
        self._wordclouds = []
        self._scores = np.zeros((4,4))

    resultChanged = Signal(list)
    wordcloudGenerated = Signal(list)
    scoresGenerated = Signal(list)
    getScore = Signal(str)
    statusUpdated = Signal(str) # Currently not useful, QML does not repaint

    @Slot(list, list)
    def analyse_images(self, url_list, checkboxes):
        self.statusUpdated.emit("Loading Tag Comparators...")
        print("Loading tag comparators...")
        global tag_comparator
        from coslab import tag_comparator
        print("Loading tag results...")
        global taggerresults
        from coslab import taggerresults

        # ToDo: add the possibility to edit this YAML in the GUI
        with open('ok.yaml', 'r') as file:
            config = yaml.safe_load(file)

        results = taggerresults.TaggerResults()
        services = {}
        # Setting up the services with coslab-core
        if checkboxes[0]:
            self.statusUpdated.emit("Loading Google Vision...")
            print("Loading Google Vision...")
            global googlecloud
            from coslab import googlecloud
            google = googlecloud.GoogleCloud(config['google']['service_account_info'])
            services['google'] = google
        if checkboxes[1]:
            # ToDo: configure IBM
            pass
        if checkboxes[2]:
            self.statusUpdated.emit("Loading Azure Vision...")
            print("Loading Azure Vision...")
            global azure_vision
            from coslab import azure_vision
            azure = azure_vision.Azure(config['azure']['subscription_key'], config['azure']['endpoint'])
            services['azure'] = azure
        if checkboxes[3]:
            self.statusUpdated.emit("Loading Amazon Web Service...")
            print("Loading Amazon Web Service...")
            global aws
            from coslab import aws
            amazon = aws.AWS(config['aws']['api_id'], config['aws']['api_key'], config['aws']["api_region"])
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
        wordlistAll = []
        cwd = os.getcwd() # Python and QML run in different folders so getting the full path is necessary
        # Iterating through selected services
        for service in self._services:
            wordlist = []
            # Iterating through labels
            for image in self._results.labels:
                for label in self._results.labels[image][service]:
                    wordlist.append(label['label'])
                    wordlistAll.append(label['label'])
            # Generating individual service wordcloud
            print("Creating wordcloud for service: {}".format(service))
            wc = WordCloud().generate(' '.join(wordlist))
            wc.to_file('{}/wordclouds/{}_wordcloud.png'.format(cwd, service))
            self._wordclouds.append('{}/wordclouds/{}_wordcloud.png'.format(cwd, service))
        print("Generating global wordlist...")
        # Generating all services wordcloud
        wc = WordCloud().generate(' '.join(wordlistAll))
        wc.to_file('{}/wordclouds/{}_wordcloud.png'.format(cwd, 'all_services'))
        self._wordclouds.append('{}/wordclouds/{}_wordcloud.png'.format(cwd,'all_services'))
        # Sending signal to QML with generated files
        qt_urls = [("file:///" + path) for path in self._wordclouds]
        self.wordcloudGenerated.emit(qt_urls)

    @Slot()
    def generate_scores(self):
        all_services = ['aws', 'azure', 'watson', 'google']
        scoresString = [ [ "0" for i in range(5) ] for j in range(4) ]
        for i, service in enumerate(all_services):
            for j, other_service in enumerate(all_services):
                if service in self._services and other_service in self._services:
                    compared = tag_comparator.compare_tags(self._results, service, other_service, tag_comparator.glove_comparator)
                    self._scores[i][j] = sum([value[0] for value in compared.values()])
                    scoresString[i][j] = "{:.2f}".format(self._scores[i][j])
        self.scoresGenerated.emit(scoresString)

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    analyst = AnalyseImages()

    engine.rootContext().setContextProperty("analyseImages", analyst)
    engine.rootContext().setContextProperty("generateWordcloud", analyst)
    engine.rootContext().setContextProperty("generateScores", analyst)
    engine.rootContext().setContextProperty("getScore", analyst)

    qml_file = Path(__file__).resolve().parent / "UI/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
