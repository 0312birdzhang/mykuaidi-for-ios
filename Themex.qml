import QtQuick 2.3
import QtQuick.Controls 1.2

QtObject {
    id: mytheme;

//    // color
//    property color colorLight: tbsettings.whitetheme ? "#191919" : "#ffffff";
//    property color colorMid: tbsettings.whitetheme ? "#505050" : "#d2d2d2";
//    property color colorMarginLine: tbsettings.whitetheme ? "#a9a9a9" : "#444444";
//    property color colorTextSelection: tbsettings.whitetheme ? "#4591ff" : "#0072b2";
//    property color colorDisabled: tbsettings.whitetheme ? "#b2b2b4" : "#7f7f7f";
    property color secondaryColor: "#666666";
    property color highlightColor: "#000000";

    // padding size
    property int paddingSmall: 8;
    property int paddingMedium: 12;
    property int paddingLarge: 24;
    property int paddingXLarge: 48;

    // graphic size
    property int graphicSizeTiny: 32;
    property int graphicSizeSmall: 48;
    property int graphicSizeMedium: 64;
    property int graphicSizeLarge: 80;
    property int thumbnailSize: 120;

    // font size
    property int fontSizeTiny: 14;
    property int fontSizeExtraSmall: 16;
    property int fontSizeSmall: 22;
    property int fontSizeMedium: 24;
    property int fontSizeLarge: 26;
    property int fontSizeExtraLarge: 28;
    property int fontSizeHuge: 32;
    property variant subTitleFont: __subTitleText.font;
    property variant labelFont: __label.font;
    property variant titleFont: __titleText.font;

    // size
    property variant sizeTiny: Qt.size(graphicSizeTiny, graphicSizeTiny);
    property variant sizeMedium: Qt.size(graphicSizeMedium, graphicSizeMedium);


    // private
    property Text __titleText: Text {
        font.pixelSize: fontSizeLarge;
        font.family: "Nokia Pure Text";
    }
    property Text __subTitleText: Text {
        font.pixelSize: fontSizeSmall;
        font.family: "Nokia Pure Text";
        font.weight: Font.Light;
    }
    property Text __label: Text {
        font.pixelSize: fontSizeMedium;
        font.family: "Nokia Pure Text";
    }
}
