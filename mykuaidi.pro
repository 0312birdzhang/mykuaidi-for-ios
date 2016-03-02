TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc


ios: {
    QMAKE_INFO_PLIST = $$PWD/Quicksand-Info.plist
    QTPLUGIN +=  qsvg
    OTHER_FILES += mykuaidi-Info.plist

    icons.files += gfx/btn.png
    QMAKE_BUNDLE_DATA += icons
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    Themex.qml \
    main.qml \
    ResultPage.qml \
    Silica/*.qml \
    Silica/*.js \
    SaveDialog.qml \
    FirstPage.qml \
    ShowPage.qml \
    js/storage.js \
    js/parser.js \
    js/allposts.js \
    AutoPostNamePage.qml

TRANSLATIONS += translations/mykuaidi.ts
