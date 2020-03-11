import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Felgo 3.0

Page {
	id: studentDetailPage
	title: selectedStudentName

	property bool identityFilter: true
	property bool walkFilter: true
	property bool talkFilter: true
	property bool feedFilter: true
	property bool cleanFilter: true
	property var selectedChair: "Chair 2"

	AppImage {
		id: studentImage
		anchors.horizontalCenter: parent.horizontalCenter
		width: parent.width / 3
		height: width
		fillMode: Image.PreserveAspectFit
		source: "assets/frodo.jpg"
		defaultSource: "felgo-logo.png"
	}

	AppText {
		id: studentChairLabel
		anchors.top: studentImage.bottom
		anchors.topMargin: 4
		text: qsTr("Chair 2")
		anchors.horizontalCenter: parent.horizontalCenter
		fontSize: 12
	}

	AppText {
		id: warningTextId
		text: qsTr("This is only to be used as an estimate!")
		anchors.top: studentChairLabel.bottom
		anchors.topMargin: 2
		anchors.horizontalCenter: parent.horizontalCenter
		fontSize: 12
	}
	AppText {
		id: studentChairProgress
		anchors.top: warningTextId.bottom
		anchors.topMargin: 2
		text: qsTr("70% to Chair 3")
		anchors.horizontalCenter: parent.horizontalCenter
		fontSize: 12
	}
	ChairProgressBar {
		id: chairProgressBarId
		anchors.top: studentChairProgress.bottom
		anchors.topMargin: 5
		anchors.horizontalCenter: parent.horizontalCenter
		width: parent.width / 2
	}

	AppText {
		id: filterLabel
		text: qsTr("Filter: ")
		font.bold: true
		font.pointSize: 15
		anchors.verticalCenter: catComboBox.verticalCenter
		anchors.left: frame.left
		anchors.leftMargin: 10
	}

	Button {
		id: catComboBox
		anchors.right: frame.right
		anchors.top: chairProgressBarId.bottom
		anchors.topMargin: 30
		text: "Categories"

		onClicked: filterCategoriesDialog.open()
	}

	ComboBox {
		id: chairComboBox
		anchors.right: frame.right
		anchors.rightMargin: 200
		anchors.top: catComboBox.top
		height: Math.min(width / 2, undefined)
		model: ["Chair 2", "Chair 1", "Chair 3"]
		onCurrentTextChanged: selectedChair = currentText
	}

	Frame {
		id: frame
		x: 8
		anchors.top: catComboBox.bottom
		anchors.topMargin: 10
		width: parent.width - 20
		height: parent.height / 2
		hoverEnabled: true
		focusPolicy: Qt.StrongFocus

		AppListView {
			id: studentStepListView
			x: 0
			y: 20
			width: parent.width - 21
			height: frame.availableHeight - y - 10
			anchors.horizontalCenterOffset: 6
			spacing: 40
			anchors.horizontalCenter: parent.horizontalCenter
			currentIndex: 0
			clip: true

			model: filteredStepModel
			delegate: StepListDelegate {}
		}
	}

	RoundButton {
		id: roundButton
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 50
		anchors.right: parent.right
		anchors.rightMargin: 50
		width: parent.width / 9
		height: width
		text: "+"
		font.bold: true
		font.pointSize: 28
		visible: Theme.isDesktop ? true : false

		onClicked: newStepDialog.open()
	}

	FloatingActionButton {
		id: facButtonId
		icon: IconType.plus
		visible: Theme.isDesktop ? false : true

		onClicked: newStepDialog.open()
	}

	Dialog {
		id: newStepDialog
		title: "New Step"
		anchors.centerIn: parent
		//		height: parent.height - 150
		//		width: parent.width - 100
		positiveActionLabel: "Save"
		negativeActionLabel: "Cancel"
		autoSize: true

		AppText {
			id: nameLabel
			x: 20
			text: qsTr("Step Name")
			font.pixelSize: 12
		}

		AppTextField {
			id: textEdit
			anchors.top: nameLabel.bottom
			anchors.topMargin: 10
			width: 300
			placeholderText: qsTr("New Step")
			anchors.left: nameLabel.left
			font.pixelSize: 12
			hoverEnabled: true
			selectByMouse: true
		}

		AppText {
			id: chairLabel
			anchors.left: textEdit.left
			anchors.top: textEdit.bottom
			anchors.topMargin: 20
			text: qsTr("Chair")
			font.pixelSize: 12
		}

		ComboBox {
			id: chairComboBoxId
			anchors.top: chairLabel.bottom
			anchors.topMargin: 10
			anchors.left: chairLabel.left
			width: textEdit.width
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
			font.pixelSize: 12
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

		AppCheckBox {
			id: identityFilterCheckBox
			text: "Identity"
			checked: identityFilter
			onCheckedChanged: checked ? identityFilter = true : identityFilter = false
			y: 20
			x: 10
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
	}

	SortFilterProxyModel {
		id: filteredStepModel
		sourceModel: StepListModel {}
		filters: [
			RegExpFilter {
				roleName: "chair"
				pattern: selectedChair
			},
			AnyOf {
				ValueFilter {
					roleName: "identity"
					value: true
					enabled: identityFilter
				}
				ValueFilter {
					roleName: "walk"
					value: true
					enabled: walkFilter
				}
				ValueFilter {
					roleName: "talk"
					value: true
					enabled: talkFilter
				}
				ValueFilter {
					roleName: "feed"
					value: true
					enabled: feedFilter
				}
				ValueFilter {
					roleName: "clean"
					value: true
					enabled: cleanFilter
				}
			}
		]
	}
}

/*##^##
Designer {
	D{i:1;anchors_height:400;anchors_width:400;anchors_x:24;anchors_y:8}
}
##^##*/

