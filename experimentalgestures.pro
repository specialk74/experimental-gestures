# Add more folders to ship with the application, here
folder_01.source = qml/experimental-gestures
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# Avoid auto screen rotation
#DEFINES += ORIENTATIONLOCK

# Needs to be defined for Symbian
#DEFINES += NETWORKACCESS

symbian:TARGET.UID3 = 0xE3FF6816

# Smart Installer package's UID
# This UID is from the protected range 
# and therefore the package will fail to install if self-signed
# By default qmake uses the unprotected range value if unprotected UID is defined for the application
# and 0x2002CCCF value if protected UID is given to the application
#symbian:DEPLOYMENT.installer_header = 0x2002CCCF

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    mygesture.cpp \
    myqswipegesturerecognizer.cpp \
    myqpangesturerecognizer.cpp

# Please do not modify the following two lines. Required for deployment.
# desktopInstallPrefix=$$[QT_INSTALL_EXAMPLES]/declarative/touchinteraction/gestures/experimental-gestures
#desktopInstallPrefix=$$[QT_INSTALL_EXAMPLES]/declarative/touchinteraction/gestures/experimental-gestures
exists(qmlapplicationviewer.pri):include(qmlapplicationviewer.pri)

HEADERS += \
    mygesture.h \
    myqswipegesturerecognizer.h \
    myqpangesturerecognizer.h

OTHER_FILES += \
    qml/experimental-gestures/experimental-gestures.qml \
    Pagina.qml \
    qml/experimental-gestures/Pagina.qml

RESOURCES +=
