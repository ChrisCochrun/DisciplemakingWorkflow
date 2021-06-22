import QtQuick 2.0
import Felgo 3.0
import "../utils"

JsonListModel {
    id: studentJsonDataModel
    source: studentJsonData
    keyField: "ID"
}
