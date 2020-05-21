import QtQuick 2.0

Item {
	property bool chair1: false
	property bool chair2: true
	property bool chair3: false
	property bool chair4: false

	id: rootItem

	Row {
		id: progressRowId
		spacing: 0
		Rectangle {
			id: chair1Rect
			color: chair1 ? "blue" : "darkslategrey"
			width: rootItem.width / 4
			height: 15
		}

		Rectangle {
			id: chair1Sep
			color: "white"
			width: 1
			height: 15
			z: 1
		}

		Rectangle {
			id: chair2bg
			width: rootItem.width / 4
			height: 15
			color: "darkslategrey"
		}

		Rectangle {
			id: chair2Sep
			color: "white"
			width: 1
			height: 15
			z: 1
		}

		Rectangle {
			id: chair3bg
			width: rootItem.width / 4
			height: 15
			color: "darkslategrey"
		}

		Rectangle {
			id: chair3Sep
			color: "white"
			width: 1
			height: 15
			z: 1
		}

		Rectangle {
			id: chair4bg
			width: rootItem.width / 4
			height: 15
			color: "darkslategrey"
		}
	}

	Rectangle {
		id: chairProgressionRect
		width: rootItem.width / 4
		height: 15
		color: "dodgerblue"
		anchors.top: progressRowId.top
		anchors.left: progressRowId.left
		anchors.leftMargin: progressRowId.width / 2.5
	}
}
