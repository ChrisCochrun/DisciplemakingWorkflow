import QtQuick 2.12
import QtQuick.Controls 2.12
import Felgo 3.0

Item {
	id: studentDelegateItem

	Rectangle {
		id: pictureItem
		radius: 100
		width: 50
		height: width
		color: "blue"
		AppText {
			text: qsTr(name[0])
			anchors.centerIn: parent
			color: "white"
			font.pixelSize: 20
		}
	}

	Column {
		id: studentTextColumn
		anchors.left: pictureItem.right
		anchors.leftMargin: 20
		AppText {
			text: "<b>" + name + "</b>"
		}
		AppText {
			text: "<b>Age:</b> " + age
		}
		AppText {
			text: "<b>Chair: </b>" + chair
		}
	}
}
