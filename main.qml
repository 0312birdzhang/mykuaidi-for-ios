//import QtQuick 2.3
//import QtQuick.Controls 1.2
//import QtQuick.Window 2.1
import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Window 2.1
import "Silica"


ApplicationWindow {
    id:application
    visible: true
    title: qsTr("MyKuaidi")
    height: Screen.height
    width: Screen.width

    StackView{
        id:pageStack
        initialItem:Qt.resolvedUrl("FirstPage.qml")
        anchors.fill: parent
    }

    Themex{
        id:mytheme
    }

    // Implements back key navigation
    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            if (pageStack.depth > 1) {
                pageStack.pop();
                event.accepted = true;
            } else { Qt.quit(); }
        }
    }

    toolBar: BorderImage {
        border.bottom: mytheme.paddingSmall
        source: "images/toolbar.png"
        width: parent.width
        height: mytheme.graphicSizeMedium

        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: mytheme.paddingMedium
            opacity: pageStack.depth > 1 ? 1 : 0
            visible: pageStack.depth > 1
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "white" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "images/navigation_previous_item.png"
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -mytheme.paddingSmall
                onClicked: pageStack.pop()
            }
        }

        Text {
            font.pixelSize: mytheme.fontSizeHuge
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "black"
            text: qsTr("MyKuaidi")
        }
    }

}
