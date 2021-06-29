import QtQuick 2.13
import QtQuick.Controls 2.13
import Felgo 3.0
import "./utils"

Item {

    id: stepDelegateItem
    implicitHeight: dp(25) //chair === selectedChair ? 40 : -40 //selectedCategory in model ? 40 : 0
    width: parent.width
    x: dp(10)
    visible: true //chair === selectedChair ? true : false //selectedCategory in model ? true : false

    Api {
        id: restApi
    }

    Text {
        id: stepNameText
        text: Title
        elide: Text.ElideRight
        width: parent.width - dp(90)
        anchors.top: parent.top
        anchors.topMargin: dp(2)
        font.bold: true
        font.pointSize: sp(10)
    }

    Row {
        id: stepCatRow
        anchors.top: stepNameText.bottom
        anchors.topMargin: dp(5)
        spacing: dp(2)
        Text {
            id: stepCatText
            text: "Category: "
            font.bold: true
        }
        Text {
            id: identityDelText
            text: "Identity"
            visible: Identity
        }
        Text {
            id: walkDelText
            text: "Walk"
            visible: Walk
        }
        Text {
            id: talkDelText
            text: "Talk"
            visible: Talk
        }
        Text {
            id: feedDelText
            text: "Feed"
            visible: Feed
        }
        Text {
            id: cleanDelText
            text: "Clean"
            visible: Clean
        }
    }

    Text {
        id: chairText
        text: "Chair: "
        font.bold: true
        anchors.top: stepCatRow.bottom
        anchors.topMargin: dp(4)
        elide: Text.ElideRight
    }

    Text {
        id: chairValueText
        text: Chair
        elide: Text.ElideRight
        width: parent.width - dp(80)
        anchors.top: stepCatRow.bottom
        anchors.topMargin: dp(4)
        anchors.left: chairText.right
    }

    AppCheckBox {
        anchors.right: stepDelegateItem.right
        anchors.rightMargin: studentStepListView.x + dp(50)
        visible: !onStepsPage
        id: checkStep
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: dp(8)
        checkBoxSize: Theme.isDesktop === true ? dp(30) : dp(40)
        iconSize: Theme.isDesktop === true ? dp(20) : dp(20)

        onCheckedChanged: timer.start()
    }

    Timer {
        id: timer
        interval: 400
        onTriggered: {
            console.log(Title + " has been toggled")
            /* console.log("updateStudent API function: ") */
            /* restApi.updateStudent(selectedStudent) */
            console.log("finishActionStep API function: ")
            restApi.finishActionStep(model, selectedStudent)
        }
    }

    Rectangle {
        id: seperatorRect
        anchors.top: chairText.bottom
        anchors.topMargin: studentStepListView.spacing / dp(6)
        height: 1
        width: parent.width - dp(30)
        color: "darkgray"
    }
}
