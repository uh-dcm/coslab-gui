# This Python file uses the following encoding: utf-8
import sys
import yaml
from wordcloud import WordCloud
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Signal, Slot, Property

from coslab import aws
from coslab import googlecloud
from coslab import azure_vision
from coslab import taggerresults
from coslab import tag_comparator


class AnalyseImages(QObject):
    def __init__(self):
        super().__init__()
        self._result = ""
        self._wordClouds = {}

    resultChanged = Signal(list)

    @Property(list, notify=resultChanged)
    def result(self):
        return self._result
    
    def generate_wordcloud(self, results, service):
        wordlist = []
        
        for image in results.labels:
            for label in results.labels[image][service]:
                wordlist.append(label['label'])

        return WordCloud().generate(' '.join(wordlist))


    @Slot(list, list)
    def analyse_images(self, url_list, checkboxes):

        with open('ok.yaml', 'r') as file:
            config = yaml.safe_load(file)

        results = taggerresults.TaggerResults()
        services = {}

        if checkboxes[0]:
            google = googlecloud.GoogleCloud(config['google']['service_account_info'])
            services['google'] = google

        if checkboxes[1]:
            # ToDo: configure IBM
            pass

        if checkboxes[2]:
            azure = azure_vision.Azure(config['azure']['subscription_key'], config['azure']['endpoint'])
            services['azure'] = azure


        if checkboxes[3]:
            aws = aws.AWS(config['aws']['api_id'], config['aws']['api_key'], config['aws']["api_region"])
            services['aws'] = aws

        for service in services:
            self._wordclouds['service'] = generate_wordcloud(results, service)
        

        self.resultChanged.emit(self._result)


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    analyst = AnalyseImages()
    engine.rootContext().setContextProperty("analyseImages", analyst)

    qml_file = Path(__file__).resolve().parent / "UI/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
