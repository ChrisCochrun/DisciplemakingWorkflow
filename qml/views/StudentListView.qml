import QtQuick 2.12
import Felgo 3.0
import "../models"

Page {
	title: qsTr("Students")

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
				studentListPageId.navigationStack.popAllExceptFirstAndPush(
							studentDetailPageComponent)
				selectedStudentName = FullName
				selectedStudent = model
				console.log("clicked student: " + FullName)
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
