import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.0

Rectangle{
    id: mainRoot
    width: 700
    height: 200
    color: "#2e2f30"
    property double scaleFactor: Math.min(mainRoot.height/200,mainRoot.width/700)

    Row {
        id: npyFileSelector
        spacing: 10*scaleFactor
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 15*scaleFactor
        anchors.topMargin: 10*scaleFactor
        Rectangle {
            width: 60*scaleFactor
            height: 20*scaleFactor
            color: "transparent"
            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: 'NPY文件: '
                color: "whitesmoke"
                font.bold: true
                font.pointSize: 9.5
            }
        }
        Rectangle {
            id: npyFilePathShowerBg
            width: 500*scaleFactor
            height: 20*scaleFactor
            color: "snow"
            Text{
                id: npyFilePathShower
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: anchors.leftMargin
                anchors.verticalCenter: parent.verticalCenter
                text: ""
                color: "black"
                font.pointSize: 9.5
                elide: Text.ElideLeft
            }
        }
        Image {
            anchors.verticalCenter: parent.verticalCenter
            width: 18*scaleFactor
            height: 18*scaleFactor
            source: "./icons/folder.png"
            MouseArea {
                anchors.fill: parent
                enabled: true
                onClicked: {
                    npyFileDialog.open()
                }
            }
        }
        Rectangle{
            id:npyFileBtn
            color:npyFileBtnMouseArea.pressed ? "lightgray" : "transparent"
            width: 30*scaleFactor
            height: 20*scaleFactor
            anchors.verticalCenter: parent.verticalCenter
            border.color: "lightgray"
            border.width: 2
            Text {
                text: "OK"
                anchors.centerIn: parent
                color: "whitesmoke"
                font.pointSize: 9.5
                font.bold: true
            }
            MouseArea{
                id: npyFileBtnMouseArea
                anchors.fill:parent
                hoverEnabled: true
                onEntered: {
                    npyFileBtn.color = "#666666"
                }
                onExited: {
                    npyFileBtn.color = "transparent"
                }
                onClicked: {
                    npyHandler.readNpyFile(npyFilePathShower.text)
                    npyShapeLength.text = npyHandler.getShapeLength()
                    npyShapeSize.text = npyHandler.getShapeSize()
                }
            }
        }
        FileDialog {
            id: npyFileDialog
            nameFilters: ["Config Files (*.npy)"]
            title: "请选择NPY文件:"
            onFileUrlChanged: {
                npyFilePathShower.text = globalHandler.getFilePathFromUrl(fileUrl)
            }
        }
    }

    Row{
        id: npyShapeInfo
        anchors.left: npyFileSelector.left
        anchors.top: npyFileSelector.bottom
        anchors.topMargin: 10*scaleFactor
        Rectangle {
            width: 40*scaleFactor
            height: 20*scaleFactor
            color: "transparent"
            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: '维度: '
                color: "whitesmoke"
                font.bold: true
                font.pointSize: 9.5
            }
        }
        Text{
            id: npyShapeLength
            anchors.verticalCenter: parent.verticalCenter
            width: 20*scaleFactor
            text: "-"
            color: "whitesmoke"
            font.pointSize: 9.5
            elide: Text.ElideLeft
        }
        Rectangle {
            width: 40*scaleFactor
            height: 20*scaleFactor
            color: "transparent"
            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                text: '大小: '
                color: "whitesmoke"
                font.bold: true
                font.pointSize: 9.5
            }
        }
        Text{
            id: npyShapeSize
            anchors.verticalCenter: parent.verticalCenter
            width: 400*scaleFactor
            text: "-"
            color: "whitesmoke"
            font.pointSize: 9.5
            elide: Text.ElideLeft
        }
    }

    Column{
        id: npyDimensionSelector
        anchors.left: npyShapeInfo.left
        anchors.top: npyShapeInfo.bottom
        anchors.topMargin: 10*scaleFactor
        spacing: 10*scaleFactor

        Row {
            id: dimensions
            spacing: 10*scaleFactor
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: 'x: '
                    color: "whitesmoke"
                    font.bold: true
                    font.pointSize: 9.5
                }
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: axisX
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: 'y: '
                    color: "whitesmoke"
                    font.bold: true
                    font.pointSize: 9.5
                }
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: axisY
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: 't: '
                    color: "whitesmoke"
                    font.bold: true
                    font.pointSize: 9.5
                }
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: axisT
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
        }

        Row {
            id: minValue
            spacing: 10*scaleFactor
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: 'Min: '
                    color: "whitesmoke"
                    font.bold: true
                    font.pointSize: 9.5
                }
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: minX
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: minY
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: minT
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
        }

        Row {
            id: maxValue
            spacing: 10*scaleFactor
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: 'Max: '
                    color: "whitesmoke"
                    font.bold: true
                    font.pointSize: 9.5
                }
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: maxX
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: maxY
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
            Rectangle {
                width: 20*scaleFactor
                height: 20*scaleFactor
                color: "transparent"
            }
            Rectangle {
                width: 80*scaleFactor
                height: 20*scaleFactor
                color: "snow"
                TextInput{
                    id: maxT
                    height: parent.height
                    anchors.left: parent.left
                    anchors.leftMargin: 10*scaleFactor
                    width: parent.width-2*anchors.leftMargin
                    anchors.verticalCenter: parent.verticalCenter
                    color: "black"
                    font.pointSize: 9.5
                    selectByMouse: true
                    wrapMode: TextInput.WordWrap
                    verticalAlignment: TextInput.AlignVCenter
                    validator: IntValidator{bottom: -1;}
                    text: '-1'
                }
            }
        }
    }

    Rectangle{
        width: 40*scaleFactor
        height: 20
        anchors.left: npyDimensionSelector.left
        anchors.top: npyDimensionSelector.bottom
        anchors.topMargin: 10*scaleFactor
        color:drawMouseArea.pressed ? "lightgray" : "transparent"
        border.color: "lightgray"
        border.width: 2
        Text{
            anchors.centerIn: parent
            text: "绘画"
        }
        MouseArea{
            id: drawMouseArea
            anchors.fill: parent
            onClicked:{
                npyHandler.draw(axisX.text,minX.text.maxX.text,axisY.text,minY.text,maxY.text,axisT.text,minT.text,maxT.text)
            }
        }
    }
}