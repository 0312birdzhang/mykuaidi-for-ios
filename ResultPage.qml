//import QtQuick 2.3
//import QtQuick.Controls 1.2
//import QtQuick.Window 2.1
import QtQuick 2.0
import QtQuick.Controls 1.0
import "Silica"

Item {
    id:resultPage
    width: parent.width
    height: parent.height
    anchors.fill: parent
    Component.onCompleted: {
        application.apptitle = qqsTr("ResultPage");
    }
    Label{
        text: "Test"
        anchors.centerIn: parent
        MouseArea{
            anchors.fill: parent
            onClicked: pageStack.pop()
        }
    }
}




