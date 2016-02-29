import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Item{
    id:firstpage
    width: parent.width
    height: parent.height
    Label {
        id:mytitle
        text: qsTr("MyKuaidi")
        anchors{
            top:parent.top
            topMargin: mytheme.paddingMedium
            right:parent.right
            rightMargin: mytheme.paddingMedium
        }
        font.pixelSize: mytheme.fontSizeExtraLarge
    }
    Column {
        id: column
        anchors{
            top:mytitle.bottom
            topMargin: mytheme.paddingMedium
        }

        width: parent.width
        spacing: mytheme.paddingLarge

        Rectangle{
            id:rectangle
            width: application.width - mytheme.paddingLarge
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
                    horizontalCenter: column.horizontalCenter
                }
                width:parent.width
                anchors.topMargin: mytheme.paddingLarge
                visible: true
                spacing: mytheme.paddingMedium
                TextField {
                    id:postid
                    width:application.width * 0.8
                    anchors.horizontalCenter: parent.horizontalCenter
                    height:implicitHeight + mytheme.paddingMedium
                    inputMethodHints:Qt.ImhNoAutoUppercase | Qt.ImhUrlCharactersOnly | Qt.ImhNoPredictiveText
                    echoMode: TextInput.Normal
                    font.pixelSize: mytheme.fontSizeMedium
                    placeholderText: "请输入快递号"
                    focus: true
                    //label: "快递号"
                    style: TextFieldStyle {
                        textColor: "black"
                        background: Rectangle {
                            radius: 2
                            implicitWidth: 100
                            implicitHeight: 24
                            border.color: "#333"
                            border.width: 1
                        }
                    }
                }
                Row{
                    id:buttons
                    spacing: mytheme.paddingLarge
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        id:querybutton
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

                            }
                        }
                        style: ButtonStyle {
                            label: Text {
                                renderType: Text.NativeRendering
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Helvetica"
                                font.pointSize: mytheme.fontSizeMedium
                                //color: "blue"
                                text: querybutton.text
                            }
                        }
                    }
                    Button{
                        id:hsbutton
                        text:"历史记录"
                        onClicked: {
                            pageStack.push(Qt.resolvedUrl("ResultPage.qml") )
                        }
                        style: ButtonStyle {
                            label: Text {
                                renderType: Text.NativeRendering
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font.family: "Helvetica"
                                font.pointSize: mytheme.fontSizeMedium
                                //color: "blue"
                                text: hsbutton.text
                            }
                        }
                    }
                }
            }

        }
    }
}
