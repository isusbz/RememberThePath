import QtQuick 2.0

Item {
    id: buttony
    width: 50
    height: 50

    property string label
    property alias backgroundColor: background.color
    signal pressed

    Rectangle {
        id: background
        anchors.fill: parent
        color: touchArea.pressed ? "lightblue" : "gray"
        radius: 10

        Text {
            anchors.centerIn: parent
            text: label
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
            color: "black"
            font.bold: true
            style: Text.Outline
            styleColor: touchArea.pressed ? "white" : "transparent"
        }

        MouseArea {
            id: touchArea
            anchors.fill: parent
            onClicked: buttony.pressed()
        }
    }
}
