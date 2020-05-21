import QtQuick 2.0
import Felgo 3.0
import "../models"

Page {
	title: qsTr("Students")

	AppListView {
		id: studentAppListId

		model: studentSortFilterProxyListModel

		delegate: SimpleRow {
			id: studentSimpleRow
			text: FullName
			detailText: "Chair " + Chair
			style: StyleSimpleRow {
				spacing: 12
			}
			onSelected: {
				studentListPageId.navigationStack.push(
							studentDetailPageComponent)
				selectedStudentName = FullName
				selectedStudent = modelData
			}
		}

		anchors.top: showListSearch ? studentSearchBar.bottom : parent.top

		flickDeceleration: 5000
		//		showSearch: showListSearch
		//		onSearch: studentSearchBar.show()
	}

	SearchBar {
		id: studentSearchBar
		visible: showListSearch
	}

	SortFilterProxyModel {
		id: studentSortFilterProxyListModel
		sourceModel: StudentListModel {}

		sorters: StringSorter {
			roleName: "FullName"
			enabled: true
		}

		filters: AnyOf {
			RegExpFilter {
				id: studentFirstNameFilterId
				roleName: "Title"
				pattern: studentSearchBar.text
				enabled: true
				caseSensitivity: "CaseInsensitive"
			}
			RegExpFilter {
				id: studentLastNameFilterId
				roleName: "LastName"
				pattern: studentSearchBar.text
				enabled: true
				caseSensitivity: "CaseInsensitive"
			}
		}
	}
}
