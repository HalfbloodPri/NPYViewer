from PyQt5.QtCore import pyqtSlot, QObject

class GlobalHandler(QObject):
    
    @pyqtSlot(str,result=str)
    def getFileNameFromPath(self,fileUrl):
        return fileUrl.split("/")[-1]

    @pyqtSlot(str,result=str)
    def getFilePathFromUrl(self,fileUrl):
        return fileUrl[8:]

globalHandler = GlobalHandler()