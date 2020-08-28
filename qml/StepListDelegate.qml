import QtQuick 2.13
import QtQuick.Controls 2.13
import Felgo 3.0

Item {

	id: stepDelegateItem
	implicitHeight: 25 //chair === selectedChair ? 40 : -40 //selectedCategory in model ? 40 : 0
	width: parent.width - 20
	visible: true //chair === selectedChair ? true : false //selectedCategory in model ? true : false

	Text {
		id: stepNameText
		text: Title
		elide: Text.ElideRight
		width: parent.width - dp(80)
		anchors.top: parent.top
		anchors.topMargin: dp(2)
	}

	Row {
		id: stepCatRow
		anchors.top: stepNameText.bottom
		anchors.topMargin: dp(10)
		spacing: dp(3)
		Text {
			id: stepCatText
			text: "Category: "
            font.bold: true
			anchors.top: parent.top
		}
		Text {
			id: identityDelText
			text: qsTr("Identity")
			visible: Identity
		}
		Text {
			id: walkDelText
			text: qsTr("Walk")
			visible: Walk
		}
		Text {
			id: talkDelText
			text: qsTr("Talk")
			visible: Talk
		}
		Text {
			id: feedDelText
			text: qsTr("Feed")
			visible: Feed
		}
		Text {
			id: cleanDelText
			text: qsTr("Clean")
			visible: Clean
		}
	}

	Text {
		id: chairText
		text: Chair.value
		elide: Text.ElideRight
		width: parent.width - dp(80)
		anchors.top: stepCatRow.bottom
		anchors.topMargin: dp(2)
	}

	AppCheckBox {
		anchors.right: stepDelegateItem.right
		anchors.rightMargin: studentStepListView.x + dp(20)
		visible: !onStepsPage
		id: checkStep
		anchors.top: parent.top
		anchors.topMargin: studentStepListView.spacing / dp(2)
		checkBoxSize: Theme.isDesktop === true ? dp(30) : dp(30)
		iconSize: Theme.isDesktop === true ? dp(20) : dp(20)

		onCheckedChanged: timer.start()
	}

	Timer {
		id: timer
		interval: 400
		onTriggered: console.log(
						 Title + " has been toggled") //studentStepListView.model.remove(index)
	}

	Rectangle {
		id: seperatorRect
		anchors.top: stepCatRow.bottom
		anchors.topMargin: studentStepListView.spacing / dp(2)
		height: 1
		width: parent.width - checkStep.anchors.rightMargin
		color: "lightgray"
	}
}
