import QtQuick 2.13
import Felgo 3.0

Page {
    id: stepDetailPage
    title: selectedStep.Title

    AppText {
        id: description
        text: selectedStep.Description
        anchors.top: parent.top
        anchors.topMargin: dp(20)
        anchors.horizontalCenter: parent.horizontalCenter
        fontSize: sp(12)
        width: parent.width - dp(40)
    }

    AppText {
        id: chair
        text: selectedStep.Chair
        anchors.top: description.bottom
        anchors.topMargin: dp(20)
        anchors.horizontalCenter: parent.horizontalCenter
        fontSize: sp(12)
    }
}
