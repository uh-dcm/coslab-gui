# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Signal, Slot, Property


class AnalyseImages(QObject):
    def __init__(self):
        super().__init__()
        self._result = ""

    resultChanged = Signal(list)

    @Property(list, notify=resultChanged)
    def result(self):
        return self._result
    
    @Slot(list, list)
    def analyse_images(self, url_list, checkboxes):
        print(url_list)
        print(checkboxes)
        self._result = ["this is a test", "this is also a test"]
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
