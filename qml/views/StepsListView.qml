import QtQuick 2.0
import QtQuick.Controls 2.12
import Felgo 3.0
import "../models"

Page {
	title: qsTr("Steps")

	rightBarItem: NavigationBarItem {
		IconButton {
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			anchors.rightMargin: dp(6)
			icon: IconType.search
			color: Theme.platform === "ios" ? "blue" : "white"
			selectedIcon: IconType.times
			toggle: true
			onToggled: showListSearch = !showListSearch
		}
	}

	ListView {
		id: stepsList
		height: parent.height
		width: parent.width

		model: StepListModel {}
		delegate: SimpleRow {
			id: studentSimpleRow
			text: name
			detailText: chair
			style: StyleSimpleRow {
				spacing: 12
			}
		}
	}
}
