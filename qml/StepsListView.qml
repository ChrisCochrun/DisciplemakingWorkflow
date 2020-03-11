import QtQuick 2.0
import QtQuick.Controls 2.12
import Felgo 3.0

Page {
	title: qsTr("Steps")
	ListView {
		id: stepsList
		height: parent.height
		width: parent.width
		spacing: 60

		model: StepListModel {}
		delegate: Item {
			id: stepDelegateItem
			x: 10
			width: parent.width - 20

			Row {
				id: stepCatRow
				anchors.top: parent.top
				spacing: 5
				Text {
					id: stepCatText
					text: "Category: "
					font.bold: true
					anchors.top: parent.top
					anchors.topMargin: 2
				}
				Repeater {
					model: category
					anchors.top: stepCatText.top
					anchors.topMargin: 2
					Text {
						text: name
					}
				}
			}
			Text {
				id: stepNameText
				text: name
				wrapMode: Text.WordWrap
				width: parent.width - 80
				anchors.top: stepCatRow.bottom
				anchors.topMargin: 8
			}

			Text {
				id: stepChairText
				text: qsTr(chair)
				anchors.top: stepCatRow.top
				anchors.topMargin: 2
				anchors.right: checkStep.left
				anchors.rightMargin: 30
			}

			Button {
				anchors.right: parent.right
				id: checkStep
				anchors.top: parent.verticalCenter
				text: "Delete"
				onClicked: function () {
					console.log("removed index: ", index)
					stepsList.model.remove(index)
				}
			}

			Rectangle {
				id: seperatorRect
				anchors.top: stepNameText.bottom
				anchors.topMargin: 5
				height: 2
				width: parent.width
				color: "black"
			}
		}
	}
}
