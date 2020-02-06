import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    id: app
    visible: true
    width: 500
    height: 500
    title: qsTr("Magic Path")

    property bool timerEnabled
    property bool titleColor
    property int vOff
    property int hOff
    property int steps: pathArray.length
    property var pathArray: []

    Timer {
        repeat: timerEnabled
        running: timerEnabled
        interval: 200
        onTriggered: titleColor = !titleColor
    }

    Timer {
        repeat: timerEnabled
        running: timerEnabled
        interval: 300
        onTriggered: {
            steps = pathArray.length
            if (pathArray[0] !== "") {
                followPath()
            }
        }
    }

    function followPath() {
        switch(pathArray[0]) {
        case 0:
            vOff -= 10
            break;
        case 1:
            hOff -= 10
            break;
        case 2:
            hOff += 10
            break;
        case 3:
            vOff += 10
            break;
        default:
            timerEnabled = false
            titleColor = false
            break;
        }
        if (pathArray.length !== undefined) {
            pathArray.shift()
        }
    }

    function reset() {
        timerEnabled = false
        titleColor = false
        vOff = 0
        hOff = 0
        pathArray = []
        steps = pathArray.length
    }
    Rectangle {
        anchors.fill: parent
        color: "black"
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.baseline: parent.top
        anchors.baselineOffset: parent.height * 0.07
        text: "The Rocking Path"
        font.pixelSize: 25
        color: "white"
        font.bold: true
        style: Text.Outline
    }

    Rectangle {
        width: parent.width * 0.9
        height: parent.height * 0.6
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#7fb0ff"
        radius: 40
        clip: true

        Rectangle {
            width: 100
            height: 100
            anchors.centerIn: parent
            anchors.verticalCenterOffset: vOff
            anchors.horizontalCenterOffset: hOff
            color: titleColor ? "white" : "#8f00ff"
            radius: 50

            Text {
                anchors.centerIn: parent
                font.pixelSize: 20
                color: titleColor ? "#8f00ff" : "white"
                text: "Steps\n" + steps
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
            }

            Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: 300 } }
            Behavior on anchors.horizontalCenterOffset { NumberAnimation { duration: 300 } }
        }
    }

    Hardkey {
        width: 70
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        label: "Reset"
        onPressed: reset()
    }

    Hardkey {
        id: startPathHK
        width: 70
        height: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        label: "Close"
        onPressed: app.close()
    }

    Item {
        width: 150
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height * 0.07

        Hardkey {
            width: 70
            height: 30
            anchors.centerIn: parent
            label: "Start"
            onPressed: timerEnabled = !timerEnabled
            enabled: pathArray.length !== undefined
        }

        Hardkey {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            label: "^"
            onPressed: {
                pathArray.push(0)
                steps = pathArray.length
            }
        }

        Hardkey {
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            label: "<"
            onPressed: {
                pathArray.push(1)
                steps = pathArray.length
            }
        }

        Hardkey {
            width: 30
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            label: ">"
            onPressed: {
                pathArray.push(2)
                steps = pathArray.length
            }
        }

        Hardkey {
            width: 30
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            label: "v"
            onPressed: {
                pathArray.push(3)
                steps = pathArray.length
            }
        }
    }
}
