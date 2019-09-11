import numpy as np 
from PyQt5.QtCore import pyqtSlot, QObject

class NPYHandler(QObject):

    def __init__(self):
        QObject.__init__(self)
        self.filePath = ''
        self.npyFile = None
        self.shape = []
        self.shapeString = ''
        self.length = 0

    @pyqtSlot(str,result=bool)
    def readNpyFile(self,filePath):
        self.filePath = filePath
        try:
            self.npyFile = np.load(self.filePath)
            self.shape = self.npyFile.shape
            self.updateShapeLength()
            self.updateShapeString()
            return True
        except BaseException as e:
            print('Error while reading .npy file: ' + str(e))
            return False

    def updateShapeString(self):
        #print(self.shape)
        if self.length == 0:
            return ''
        self.shapeString = str(self.shape[0])
        for i in range(self.length-1):
            self.shapeString += ' * ' + str(self.shape[i+1])
        #print(self.shapeString)

    def updateShapeLength(self):
        self.length = len(self.shape)

    @pyqtSlot(result=str)
    def getShapeSize(self):
        return self.shapeString

    @pyqtSlot(result=str)
    def getShapeLength(self):
        return str(self.length)

    @pyqtSlot(str,str,str,str,str,str,str,str,str)
    def draw(self,x,minX,maxX,y,minY,maxY,t,mint,maxt):
        print(x,minX,maxX,y,minY,maxY,t,mint,maxt)

npyHandler = NPYHandler()