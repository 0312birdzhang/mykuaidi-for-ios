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

}
