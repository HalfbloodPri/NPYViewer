from PyQt5.QtCore import QUrl, QObject, pyqtSlot, pyqtSignal
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView
import sys
import logging
import globalHandler
import npyHandler

logging.basicConfig(level=logging.DEBUG,
                    filename='log.log',
                    format='[%(asctime)s] %(message)s',
                    datefmt='%Y-%m-%d %H:%M:%S',
                    filemode='a')

path = 'mainWindow.qml'
app = QGuiApplication([])
view = QQuickView()
view.engine().quit.connect(app.quit)
view.setSource(QUrl(path))
view.show()

context = view.rootContext()
root = view.rootObject()

context.setContextProperty("globalHandler", globalHandler.globalHandler)
context.setContextProperty("npyHandler", npyHandler.npyHandler)

app.exec_()