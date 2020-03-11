import QtQuick 2.0
import Felgo 3.0

Page {
	title: qsTr("Student List")

	AppListView {
		id: studentAppListId

		model: StudentListModel {}
		delegate: SimpleRow {
			id: row
			text: name
			detailText: "Chair " + chair
			style: StyleSimpleRow {
				spacing: 12
			}
			onSelected: {
				studentListPageId.navigationStack.push(
							studentDetailPageComponent)
				selectedStudentName = name
			}
		}

		flickDeceleration: 5000
		showSearch: showListSearch
	}

	SortFilterProxyModel {
		sourceModel: StudentListModel {}
		filters: RegExpFilter {
			roleName: name
		}
	}
}
