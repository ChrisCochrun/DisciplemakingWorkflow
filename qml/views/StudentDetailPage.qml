import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtGraphicalEffects 1.0
import Felgo 3.0
import "../"
import "../models"
import "../utils"

Page {
    id: studentDetailPage
    title: selectedStudent.FullName + " ID: " + selectedStudent.ID

    property bool identityFilter: true
    property bool walkFilter: true
    property bool talkFilter: true
    property bool feedFilter: true
    property bool cleanFilter: true
    property bool filterBoxOpened: false
    property var studentSteps: null
    property var studentPicture: null

    Api {
        id: restApi
    }

    Component.onCompleted: {
        getStudentSteps()
        console.log(JSON.stringify(studentSteps, null, 4))
        console.log(JSON.stringify(selectedStudent.Picture[0] + "?size=300", null, 4))

        
        HttpRequest
            .get(selectedStudent.Picture[0])
            .set("Authorization", "Token " + accessToken)
            .then(
                function (res) {
                    studentPicture = res.body
                }
            )
    }

    rightBarItem: NavigationBarItem {
        IconButtonBarItem {
            icon: IconType.filter
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: dp(6)
            color: Theme.platform === "ios" ? "blue" : "white"
            onClicked: filterCategoriesDialog.open()
        }
    }

    RoundedImage {
        id: studentImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: dp(10)
        width: parent.width / 3
        height: width
        fillMode: Image.PreserveAspectCrop
        source: selectedStudent.Picture[0]
        radius: width / 2
    }

    AppText {
        id: studentChairLabel
        anchors.top: studentImage.bottom
        anchors.topMargin: dp(12)
        anchors.horizontalCenter: parent.horizontalCenter
        fontSize: sp(8)
        text: qsTr("Chair " + selectedChair)
    }
    AppText {
        id: warningTextId
        anchors.top: studentChairLabel.bottom
        anchors.topMargin: 2
        anchors.horizontalCenter: parent.horizontalCenter
        fontSize: sp(5)
        text: "This is only to be used as an estimate!"
    }
    AppText {
        id: studentChairProgress
        anchors.top: warningTextId.bottom
        anchors.topMargin: dp(2)
        anchors.horizontalCenter: parent.horizontalCenter
        fontSize: sp(6)
        text: "70% to Chair " + (selectedChair + 1)
    }
    ChairProgressBar {
        id: chairProgressBarId
        anchors.top: studentChairProgress.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width / 2
    }

    Frame {
        id: stepsFrame
        x: dp(10)
        anchors.top: chairProgressBarId.bottom
        anchors.topMargin: dp(20)
        width: parent.width - dp(20)
        height: parent.height / 1.5
        hoverEnabled: true
        focusPolicy: Qt.StrongFocus

        background: Rectangle {
            color: "transparent"
            border.color: "red"//ThemeColors.dividerColor TODO need to add a real theme.
            radius: 2
        }

        AppListView {
            id: studentStepListView
            width: parent.width - 21
            height: stepsFrame.availableHeight - 60
            anchors.horizontalCenterOffset: dp(10)
            anchors.top: parent.top
            anchors.topMargin: dp(4)
            spacing: height / dp(5)
            anchors.horizontalCenter: parent.horizontalCenter
            currentIndex: 0
            clip: true

	    model: listModel
            delegate: StepListDelegate {}
        }
    }

    RoundButton {
        property alias cursorShape: mouseArea.cursorShape

        id: floatingButtonId
        icon.source: IconType.plus
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: dp(20)
        anchors.bottomMargin: dp(20)
        Icon {
            icon: IconType.plus
            anchors.centerIn: parent
            color: "white"
            size: dp(20)
        }
        background: Rectangle {
            implicitHeight: parent.implicitHeight
            implicitWidth: parent.implicitWidth
            radius: parent.radius
            color: floatingButtonId.pressed ? "#17598E" : "#1C77C3"
        }

        width: dp(40)
        height: width

        hoverEnabled: true
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onPressed: mouse.accepted = false
            cursorShape: "PointingHandCursor"
        }

        //onClicked: newStepDialog.open()
        onClicked: console.log("chair is " + selectedChair)
    }

    DropShadow {
        source: floatingButtonId
        anchors.fill: floatingButtonId
        horizontalOffset: 3
        verticalOffset: 3
        samples: 6
        radius: 11
        color: "black"
    }

    Dialog {
        id: newStepDialog
        title: "New Step"
        anchors.centerIn: parent
        //              height: parent.height - 150
        //              width: parent.width - 100
        positiveActionLabel: "Save"
        negativeActionLabel: "Cancel"
        autoSize: true

        AppText {
            id: nameLabel
            x: 20
            text: qsTr("Step Name")
            fontSize: sp(6)
            anchors.top: parent.top
            anchors.topMargin: dp(20)
        }

        AppTextField {
            id: textEdit
            anchors.top: nameLabel.bottom
            anchors.topMargin: 10
            width: parent.width - 40
            placeholderText: qsTr("New Step")
            anchors.left: nameLabel.left
            font.pixelSize: sp(12)
            hoverEnabled: true
            selectByMouse: true
        }

        AppText {
            id: chairLabel
            anchors.left: textEdit.left
            anchors.top: textEdit.bottom
            anchors.topMargin: 20
            text: qsTr("Chair")
            fontSize: sp(6)
        }

        ComboBox {
            id: chairComboBoxId
            anchors.top: chairLabel.bottom
            anchors.topMargin: 10
            anchors.left: chairLabel.left
            width: textEdit.width
            height: dp(30)
            model: ["Chair 1", "Chair 2", "Chair 3"]
        }

        AppCheckBox {
            id: identityCheckBox
            anchors {
                top: categoryLabel.bottom
                topMargin: 10
                left: categoryLabel.left
            }
            width: chairComboBoxId.width
            text: "identity"
        }

        AppCheckBox {
            id: walkCheckBox
            anchors {
                top: identityCheckBox.bottom
                topMargin: 10
                left: categoryLabel.left
            }
            width: chairComboBoxId.width
            text: "walk"
        }
        AppCheckBox {
            id: talkCheckBox
            anchors {
                top: walkCheckBox.bottom
                topMargin: 10
                left: categoryLabel.left
            }
            width: chairComboBoxId.width
            text: "talk"
        }
        AppCheckBox {
            id: feedCheckBox
            anchors {
                top: talkCheckBox.bottom
                topMargin: 10
                left: categoryLabel.left
            }
            width: chairComboBoxId.width
            text: "feed"
        }
        AppCheckBox {
            id: cleanCheckBox
            anchors {
                top: feedCheckBox.bottom
                topMargin: 10
                left: categoryLabel.left
            }
            width: chairComboBoxId.width
            text: "clean"
        }
        AppText {
            id: categoryLabel
            anchors.top: chairComboBoxId.bottom
            anchors.topMargin: 20
            anchors.left: chairLabel.left
            text: qsTr("Category")
            fontSize: sp(6)
        }

        Item {
            id: newStepDialogSpacer
            anchors.top: cleanCheckBox.bottom
            anchors.topMargin: dp(30)
            height: dp(10)
        }

        onAccepted: {
            StepListModel.append({
                                     "name": textEdit.text,
                                     "chair": chairComboBoxId.currentText,
                                     "identity": identityCheckBox.checked,
                                     "walk": walkCheckBox.checked,
                                     "talk": talkCheckBox.checked,
                                     "feed": feedCheckBox.checked,
                                     "clean": cleanCheckBox.checked
                                 })

            textEdit.clear()
            chairComboBoxId.currentIndex = 0
            if (identityCheckBox.checked)
                identityCheckBox.toggle()
            if (walkCheckBox.checked)
                walkCheckBox.toggle()
            if (talkCheckBox.checked)
                talkCheckBox.toggle()
            if (feedCheckBox.checked)
                feedCheckBox.toggle()
            if (cleanCheckBox.checked)
                cleanCheckBox.toggle()
            close()
        }
        onCanceled: close()
    }

    Dialog {
        id: filterCategoriesDialog
        autoSize: true
        negativeAction: false
        onAccepted: close()

        AppText {
            id: filterChairLabel
            anchors.top: filterButtonsRowId.bottom
            anchors.topMargin: dp(10)
            anchors.left: parent.left
            anchors.leftMargin: dp(20)
            text: qsTr("Chair Filter")
            fontSize: sp(10)
        }

        AppText {
            id: filterCatLabel
            anchors.top: parent.top
            anchors.topMargin: dp(10)
            anchors.left: parent.left
            anchors.leftMargin: dp(20)
            text: qsTr("Category Filter")
            fontSize: sp(10)
        }

        ComboBox {
            id: chairComboBox
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: filterChairLabel.bottom
            anchors.topMargin: dp(10)
            height: width / 2
            width: dp(90)
            displayText: "Chair " + currentText
            model: ["1", "2", "3", "4"]

            onActivated: selectedChair = currentIndex + 1
        }

        AppCheckBox {
            id: identityFilterCheckBox
            text: "Identity"
            checked: identityFilter
            onCheckedChanged: checked ? identityFilter = true : identityFilter = false
            anchors.top: filterCatLabel.bottom
            anchors.topMargin: dp(10)
            x: dp(20)
        }

        AppCheckBox {
            id: walkFilterCheckBox
            text: "Walk"
            checked: walkFilter
            onCheckedChanged: checked ? walkFilter = true : walkFilter = false
            anchors.top: identityFilterCheckBox.bottom
            anchors.topMargin: 20
            anchors.left: identityFilterCheckBox.left
        }

        AppCheckBox {
            id: talkFilterCheckBox
            text: "Talk"
            checked: talkFilter
            onCheckedChanged: checked ? talkFilter = true : talkFilter = false
            anchors {
                top: walkFilterCheckBox.bottom
                topMargin: 20
                left: walkFilterCheckBox.left
            }
        }

        AppCheckBox {
            id: feedFilterCheckBox
            text: "Feed"
            checked: feedFilter
            onCheckedChanged: checked ? feedFilter = true : feedFilter = false
            anchors {
                top: talkFilterCheckBox.bottom
                topMargin: 20
                left: walkFilterCheckBox.left
            }
        }

        AppCheckBox {
            id: cleanFilterCheckBox
            text: "Clean"
            checked: cleanFilter
            onCheckedChanged: checked ? cleanFilter = true : cleanFilter = false
            anchors {
                top: feedFilterCheckBox.bottom
                topMargin: 20
                left: walkFilterCheckBox.left
            }
        }

        Row {
            id: filterButtonsRowId
            anchors.top: cleanFilterCheckBox.bottom
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            AppButton {
                id: clearFiltersButtonId
                text: "Clear All"
                onClicked: {
                    identityFilterCheckBox.checked = false
                    walkFilterCheckBox.checked = false
                    talkFilterCheckBox.checked = false
                    feedFilterCheckBox.checked = false
                    cleanFilterCheckBox.checked = false
		    console.log("all filters off")
                }
            }
            AppButton {
                id: markAllFiltersButtonId
                text: "Check All"
                onClicked: {
                    identityFilterCheckBox.checked = true
                    walkFilterCheckBox.checked = true
                    talkFilterCheckBox.checked = true
                    feedFilterCheckBox.checked = true
                    cleanFilterCheckBox.checked = true
		    console.log("all filters on")
                }
            }
        }

        Item {
            id: dialogSpacer
            height: 30
            anchors.top: chairComboBox.bottom
            anchors.topMargin: dp(5)
        }
    }

    JsonListModel {
        id: listModel
        source: studentSteps
        keyField: "_id"
    }

    SortFilterProxyModel {
        id: filteredStudentStepModel
        sourceModel: listModel
        /*     filters: [ */
        /*         RegExpFilter { */
        /*             roleName: "Chair" */
        /*             pattern: selectedChair */
        /*             enabled: true */
        /*         }, */
        /*         AnyOf { */
        /*             ValueFilter { */
        /*                 roleName: "Identity" */
        /*                 value: true */
        /*                 enabled: identityFilter */
        /*             } */
        /*             ValueFilter { */
        /*                 roleName: "Walk" */
        /*                 value: true */
        /*                 enabled: walkFilter */
        /*             } */
        /*             ValueFilter { */
        /*                 roleName: "Talk" */
        /*                 value: true */
        /*                 enabled: talkFilter */
        /*             } */
        /*             ValueFilter { */
        /*                 roleName: "Feed" */
        /*                 value: true */
        /*                 enabled: feedFilter */
        /*             } */
        /*             ValueFilter { */
        /*                 roleName: "Clean" */
        /*                 value: true */
        /*                 enabled: cleanFilter */
        /*             } */
        /*         } */
        /*     ] */
    }

    function getStudentSteps() {
        studentSteps =
            stepJsonData.filter(({_id}) =>
                selectedStudent["Action Steps"].includes(_id))
    }
}

/*##^##
  Designer {
  D{i:1;anchors_height:400;anchors_width:400;anchors_x:24;anchors_y:8}
  }
  ##^##*/

