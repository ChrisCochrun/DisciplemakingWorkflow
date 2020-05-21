import QtQuick 2.0
import QtQuick.Controls 2.14

Dialog {
	id: newStepDialog
	title: "New Step"
	dim: true
	modal: true
	Text {
		id: titleText
		x: 238
		text: qsTr("Create a new step")
		anchors.horizontalCenterOffset: 0
		anchors.top: parent.top
		anchors.topMargin: 50
		anchors.horizontalCenter: parent.horizontalCenter
		font.pixelSize: 12
	}

	Pane {
		id: pane
		x: 59
		y: 152
		width: 397
		height: 48
		padding: 5

		TextEdit {
			id: textEdit
			y: 14
			width: 80
			height: 20
			text: qsTr("Text Edit")
			anchors.verticalCenterOffset: -224
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.leftMargin: 59
			font.pixelSize: 12
		}
	}

	Text {
		id: nameLabel
		x: 59
		y: 105
		text: qsTr("Step Name")
		font.pixelSize: 12
	}

	Text {
		id: chairLabel
		x: 59
		y: 230
		text: qsTr("Chair")
		font.pixelSize: 12
	}

	TextEdit {
		id: chairTextEdit
		x: 59
		y: 279
		width: 80
		height: 20
		text: qsTr("Text Edit")
		font.pixelSize: 12
	}

	Text {
		id: categoryLabel
		x: 59
		y: 333
		text: qsTr("Category")
		font.pixelSize: 12
	}

	ComboBox {
		id: categoryComboBox
		x: 59
		y: 380
		model: ["Identity", "Walk", "Talk", "Feed", "Clean"]
	}

	footer: DialogButtonBox {
		Button {
			text: qsTr("Save")
			DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
		}
		Button {
			text: qsTr("Close")
			DialogButtonBox.buttonRole: DialogButtonBox.DestructiveRole
		}
	}
}

/*##^##
Designer {
	D{i:0;autoSize:true;height:800;width:500}D{i:1;anchors_y:54}
}
##^##*/

