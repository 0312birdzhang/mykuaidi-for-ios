import QtQuick 1.1
//import com.nokia.symbian 1.1
import com.nokia.meego 1.0

Rectangle {
    id :root
    property string acceptButtonText: "Accept"
    property string rejectButtonText: "Reject"

    property string _id
    property string postnum:postid.text
    property string contentText: subcomments.text
    property bool canAccept: false

    signal rejected
    signal accepted;

    z:1000
    color: "black"
    visible: false;
    opacity: visible ? 1 : 0

    function open(id,danhao,beizhu){
        _id=id
        postid.text=danhao
        subcomments.text=beizhu
        root.visible=true
    }
    function close(){
        root.visible=false
        _id=""
        postid.text=""
        subcomments.text=""
    }
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
                text: "id: "
            }
            Text{
                color:"white"
                font.pixelSize: mytheme.fontSizeLarge
                text: "　　"+_id
            }
            Text{
                color:"#aaffffff"
                font.pixelSize: mytheme.fontSizeMedium
                text: "编辑快递号: "
            }
            TextArea {
                id:postid
                width:parent.width
                height: Math.max(mytheme.itemSizeMedium,implicitHeight)
                font.pixelSize: mytheme.fontSizeMedium
                placeholderText: "编辑您的快递单号"
            }
            Text{
                color:"#aaffffff"
                font.pixelSize: mytheme.fontSizeMedium
                text: "编辑备注信息: "
            }
            TextArea {
                id:subcomments
                width:parent.width
                height: Math.max(parent.width/3, implicitHeight)
                font.pixelSize: mytheme.fontSizeMedium
                placeholderText: "编辑您的备注"
            }
        }

    }

    ButtonRow{
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
