import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id :root
    property string acceptButtonText: "Accept"
    property string rejectButtonText: "Reject"

    property string postnum
    property string kuaidi_cn
    property string contentText: subcomments.text
    property bool canAccept: true

    signal rejected
    signal accepted;

    z:1000
    color: "black"
    visible: false;
    opacity: visible ? 1 : 0

    function open(){root.visible=true}
    function close(){root.visible=false}
    Behavior on opacity {NumberAnimation { duration: 150 }}

    anchors.fill: parent;
    MouseArea{
        anchors.fill: parent;
        onClicked: {
            root.rejected()
            close();
        }
    }
    Item{
        width:400;
        height: parent.height
        anchors{
            top:parent.top;
            topMargin: mytheme.paddingLarge
            horizontalCenter: parent.horizontalCenter;
        }
        MouseArea{
            anchors.fill: parent;
        }

        Column{
            width:parent.width
            spacing: 8
            Text{
                color:"#aaffffff"
                font.pixelSize: mytheme.fontSizeMedium
                text: "快递商: "
            }
            Text{
                color:"white"
                font.pixelSize: mytheme.fontSizeLarge
                text: "　　"+root.kuaidi_cn
            }
            Text{
                color:"#aaffffff"
                font.pixelSize: mytheme.fontSizeMedium
                text: "快递号: "
            }
            Text{
                color:"white"
                font.pixelSize: mytheme.fontSizeLarge
                text: "　　"+root.postnum
            }
            Text{
                color:"#aaffffff"
                font.pixelSize: mytheme.fontSizeMedium
                text: "备注信息: "
            }
            TextArea {
                id:subcomments
                width:parent.width
                height: Math.max(showpage.width/3, implicitHeight)
                font.pixelSize: mytheme.fontSizeMedium
                //placeholderText: "输入您的备注"
            }
        }

    }

    Row{
        width:400;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: mytheme.paddingLarge
        anchors.horizontalCenter: parent.horizontalCenter
        Button{
            text:rejectButtonText;
            onClicked: {
                rejected();
                close();
            }
        }
        Button{
            enabled: canAccept
            text:acceptButtonText;
            onClicked: {
                accepted();
                close();
            }
        }
    }
    Component.onCompleted: {

    }
}
