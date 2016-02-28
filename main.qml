import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Window 2.1


ApplicationWindow {
    id:application
    visible: true
    title: qsTr("MyKuaidi")
    height: Screen.height
    width: Screen.width
    StackView{
        id:pageStack
    }

    Themex{
        id:mytheme
    }
    Label {
        id:mytitle
        text: qsTr("MyKuaidi")
        anchors{
            top:parent.top
            topMargin: mytheme.paddingMedium
            right:parent.right
        }
        font.pixelSize: mytheme.fontSizeExtraLarge
        MouseArea{
            anchors.fill: parent
            onClicked: {
                //pageStack.push("")
            }
        }
    }
    Column {
        id: column

        width: parent.width
        spacing: mytheme.paddingLarge

        Rectangle{
            id:rectangle
            width: parent.width - mytheme.paddingLarge
            height: input.height + mytheme.paddingLarge * 3
            anchors.horizontalCenter: application.horizontalCenter
            anchors.top:mytitle.bottom
            anchors.topMargin: mytheme.paddingMedium
            border.color:mytheme.highlightColor
            color:"#00000000"
            radius: 30
            Column {
                id:input
                anchors{
                    top:rectangle.top
                    topMargin: mytheme.paddingLarge
                }
                width:parent.width
                spacing: mytheme.paddingMedium
                TextField {
                    id:postid
                    width:parent.width - mytheme.paddingMedium
                    height:implicitHeight + mytheme.paddingMedium
                    inputMethodHints:Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText
                    echoMode: TextInput.Normal
                    font.pixelSize: mytheme.fontSizeMedium
                    placeholderText: "请输入快递号"
                    //label: "快递号"
                }
                Row{
                    id:buttons
                    spacing: mytheme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        text: "查询"
                        onClicked: {
                            postid.focus=false;
                            if(postid.text&&postid.text.length>2){
                                postid.placeholderText="请输入快递号";
                                pageStack.push(Qt.resolvedUrl("ResultPage.qml"),
                                               {
                                                   "postid":postid.text,
                                               });
                            }
                            else{
                                postid.placeholderColor="red";
                            }
                        }
                    }
                    Button{
                        text:"历史记录"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("ResultPage.qml") )
                        }
                    }
                }
            }

        }
    }

}
