# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.tfcconnection.dm
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "A8D4D09BC876D99B8204303419CAE22A48438029C1315071BFC1664774E0739493C7C56C2D53CF7C4405932ACBB9DEA30F1B7777FC908DF4E57A71D6CA064D1828137EF3D3583D100B2949559CD08944DC2BB331D569C83C60C9FDB59B4E88AB2AA21B9A471F280D204E8130AD8E18EBB7AD1CCAC5E8358BA8D513E48F76B9C2555D9DC98066A035B3A208BA853680098FAA55CADBA18DE5BE9E1D5DD96AAC38BF7DD2BF8818F128377A79FFB4D8E95AFA37E2BCB48FF0856CF89E08D60DCA63B37A4C4BF00E82207AA4690C038085B0AF32835A6E4E0BCF313B3D6FE9951BDD8068A984DE818F76B94CD49A286DD5776642D34E58C885AD2819D615E632607FFDB9219483B1111CBA9A4C5D3047C8867FD8B89D74695E5C501481A86F27A7A4FD47E9F3CD9B8E38EC88DF4353CF6A55"

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += \ #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp


android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
	README.md \
	android/res/drawable-hdpi/ic_launcher.png \
	android/res/drawable-mdpi/ic_launcher.png \
	android/res/drawable-xhdpi/ic_launcher.png \
	android/res/drawable-xxhdpi/ic_launcher.png \
	android/res/values/strings.xml \
	android/res/xml/file_paths.xml \
	assets/felgo-logo.png \
	assets/frodo.jpg \
	ios/Assets.xcassets/AppIcon.appiconset/Contents.json \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x-1.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x-1.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x-1.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png \
	ios/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png \
	ios/Assets.xcassets/AppIcon.appiconset/ItunesArtwork@2x.png \
	ios/Assets.xcassets/Contents.json \
	ios/Assets.xcassets/LaunchImage.launchimage/Contents.json \
	ios/Assets.xcassets/LaunchImage.launchimage/Default1125x2436.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default1242x2208.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default1536x2048.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default2048x1536.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default2208x1242.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default2436x1125.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default640x1136.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default640x960.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default750x1334.png \
	ios/Assets.xcassets/LaunchImage.launchimage/Default768x1024.png \
	qml/AddStepDialog.qml \
	qml/ChairProgressBar.qml \
	qml/LoginPage.qml \
	qml/Main.qml \
	qml/StepListDelegate.qml \
	qml/models/StepListModel.qml \
	qml/StepsListView.qml \
	qml/StudentDetailPage.qml \
	qml/StudentListDelegate.qml \
	qml/models/StudentListModel.qml \
	qml/StudentListView.qml \
	qml/config.json \
	qml/models/StudentStepListModel.qml \
	qml/utils/Api.qml \
	qml/views/StepDetailPage.qml \
	win/app_icon.ico \
	win/app_icon.rc

HEADERS +=
