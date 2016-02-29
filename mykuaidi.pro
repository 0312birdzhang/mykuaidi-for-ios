TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc

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
    SaveDialog.qml

