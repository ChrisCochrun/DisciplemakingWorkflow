import QtQuick 2.0
import QtQuick.Controls 2.12
import Felgo 3.0

Item {

	id: stepDelegateItem
	implicitHeight: 25 //chair === selectedChair ? 40 : -40 //selectedCategory in model ? 40 : 0
	width: parent.width - 20
	visible: true //chair === selectedChair ? true : false //selectedCategory in model ? true : false

	Text {
		id: stepNameText
		text: name
		//		wrapMode: Text.WordWrap
		elide: Text.ElideRight
		  width: parent.width - 80
		anchors.top: parent.top
		anchors.topMargin: 2
	}

	Row {
		id: stepCatRow
		anchors.top: stepNameText.top
		anchors.topMargin: 20
		spacing: 5
		Text {
			id: stepCatText
			text: "Category: "
			font.bold: true
			anchors.top: parent.top
		}
		//		Repeater {
		//			model: category
		//			anchors.verticalCenter: stepCatText.verticalCenter
		//			Text {
		//				id: catNameText
		//				text: name
		//			}
		//			visible: false
		//		}
		Text {
			id: identityDelText
			text: qsTr("Identity")
			visible: identity
		}
		Text {
			id: walkDelText
			text: qsTr("Walk")
			visible: walk
		}
		Text {
			id: talkDelText
			text: qsTr("Talk")
			visible: talk
		}
		Text {
			id: feedDelText
			text: qsTr("Feed")
			visible: feed
		}
		Text {
			id: cleanDelText
			text: qsTr("Clean")
			visible: clean
		}
	}

	AppCheckBox {
		anchors.right: stepDelegateItem.right
		anchors.rightMargin: studentStepListView.x
		visible: !onStepsPage
		id: checkStep
		anchors.top: parent.top
		anchors.topMargin: 7
		onCheckedChanged: timer.start()
		checkBoxSize: Theme.isDesktop === true ? 30 : 50
		iconSize: Theme.isDesktop === true ? 20 : 30
	}

	Timer {
		id: timer
		interval: 400
		onTriggered: studentStepListView.model.remove(index)
	}

	Rectangle {
		id: seperatorRect
		anchors.top: stepCatRow.bottom
		anchors.topMargin: 14
		height: 1
		width: parent.width
		color: "lightgray"
	}
}
