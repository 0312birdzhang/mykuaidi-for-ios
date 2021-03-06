/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import QtQuick 2.0
import QtQuick.Controls 1.0
//import QtQuick.Dialogs 1.0
import "js/parser.js" as JS
import "js/storage.js" as ST
import "./Silica"

Item{
    id:showpage
    property string wuliutype
    property string postid
    property string wuliuming
    //allowedOrientations: Orientation.Landscape | Orientation.Portrait | Orientation.LandscapeInverted
    SilicaFlickable {
        anchors.fill: parent
        Component.onCompleted: {
            apptitle = "物流情况"
            ST.themeColor =  mytheme.highlightColor;
            JS.showlistModel = showlistModel;
            JS.getPostdetail(wuliutype,postid);
        }
        Component.onDestruction: {
            apptitle = "选择快递商"
        }

        ListModel {  id:showlistModel }


        SilicaListView {

            id:view
            anchors.fill:parent
            model : showlistModel
            clip: true

            delegate:
                Text {
                id:showprocess
                wrapMode: Text.WordWrap
                anchors{
                    left:parent.left
                    right:parent.right
                    margins: mytheme.paddingMedium
                }

                width: root.width -  mytheme.fontSizeMedium
                text: time+"<br/>"+maintext+"<br/>"

                //color: view.highlighted ? Theme.highlightColor : Theme.primaryColor

            }


            //VerticalScrollDecorator {}

        }
    }

    /**

    Component {
        id: firstWizardPage

        Dialog {
            canAccept: subcomments.text.length > 0
            acceptDestination: showpage
            acceptDestinationAction: PageStackAction.Pop

            onAccepted: {
                var test = ST.setKuaidi(postid,wuliutype,subcomments.text);
                if(test === "OK"){
                    //savebutton.text = "保存成功^_^";
                    addNotification("保存成功", 3)
                    savebutton.enabled = false;


                }else{
                    addNotification("保存失败", 3)
                    //savebutton.text = "保存失败%>_<%";
                }
            }

            Flickable {
                // ComboBox requires a flickable ancestor
                width: parent.width
                height: parent.height
                interactive: false
                anchors.fill: parent
                Column{
                    id: column
                    width: parent.width
                    height: rectangle.height

                    anchors{
                        //top:dialogHead.bottom
                        left:parent.left
                        right:parent.right
                    }

                    spacing: Theme.paddingLarge
                    Rectangle{
                        id:rectangle
                        width: parent.width-Theme.paddingLarge
                        height: subcomments.height + Theme.paddingLarge*3
                        anchors.horizontalCenter: parent.horizontalCenter
                        border.color:Theme.highlightColor
                        color:"#00000000"
                        radius: 30
                        TextArea {
                            id:subcomments
                            anchors{
                                bottom:rectangle.bottom
                                topMargin: Theme.paddingMedium
                            }
                            width:Screen.width - Theme.paddingLarge*4
                            height: Math.max(showpage.width/3, implicitHeight)
                            font.pixelSize: Theme.fontSizeMedium
                            placeholderText: "输入您的备注"
                            label: "备注"
                        }

                    }

                }



            }
        }
    }

    **/
    Timer{
        id:processingtimer;
        interval: 60000;
        //onTriggered: addNotification("加载失败",3)
    }

}
