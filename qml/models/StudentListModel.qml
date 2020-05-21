import QtQuick 2.0
import Felgo 3.0

JsonListModel {
	id: studentJsonDataModel
	source: studentJsonData
	keyField: "ID"
}
