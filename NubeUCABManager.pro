QT += quick
CONFIG += c++11
QT += quickcontrols2
QT += widgets

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    server/users_manager.cpp \
    server/NubeUCAB-servidor/commands.cpp \
    manager/filemanager.cpp \
    server/usermanager.cpp \
    server/servermanager.cpp

RESOURCES += qml.qrc \
    images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    fonts/fontawesome-webfont.ttf \
    img/ucab.png

HEADERS += \
    server/users_manager.h \
    server/usermanager.h \
    server/servermanager.h \
    server/NubeUCAB-servidor/FTPServer.h \
    server/NubeUCAB-servidor/commands.h \
    server/NubeUCAB-servidor/socket.h \
    server/NubeUCAB-servidor/socket_server.h \
    server/NubeUCAB-servidor/FTPRequest.h \
    server/NubeUCAB-servidor/socket_exceptions.h \
    server/NubeUCAB-servidor/FTPResponse.h \
    server/NubeUCAB-servidor/commands.h \
    server/NubeUCAB-servidor/FTPRequest.h \
    server/NubeUCAB-servidor/FTPResponse.h \
    server/NubeUCAB-servidor/FTPServer.h \
    server/NubeUCAB-servidor/socket.h \
    server/NubeUCAB-servidor/socket_exceptions.h \
    server/NubeUCAB-servidor/socket_server.h \
    server/servermanager.h \
    server/usermanager.h \
    server/users_manager.h \
    manager/filemanager.h
