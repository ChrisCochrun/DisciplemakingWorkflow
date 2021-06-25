import QtQuick 2.13
import QtQuick.Controls 2.12
import Felgo 3.0
import "../models"

Page {
	property var showStepListSearch: false

    title: qsTr("Action Steps")

    rightBarItem: NavigationBarItem {
	IconButton {
	    anchors.right: parent.right
	    anchors.verticalCenter: parent.verticalCenter
	    anchors.rightMargin: dp(6)
	    icon: IconType.search
	    color: Theme.platform === "ios" ? "blue" : "white"
	    selectedIcon: IconType.times
	    toggle: true
	    onToggled: showStepListSearch = !showStepListSearch
	}
    }

    SearchBar {
	id: stepSearchBar
	visible: showStepListSearch
    }

    AppListView {
	id: stepsList
	height: parent.height
	width: parent.width

	model: stepSortFilterProxyListModel
	delegate: SimpleRow {
	    id: studentSimpleRow
	    text: Title
	    detailText: "Chair " + Chair
	    style: StyleSimpleRow {
		spacing: 12
	    }
            onSelected: {
                // Making sure variables are properly set so that the detail
                // page gets the right info for step.
                stepListPageId.navigationStack.popAllExceptFirstAndPush(
                    stepDetailPageComponent)
                selectedStepTitle = Title
                selectedStep = model
                console.log("clicked step: " + Title)
            }

	}
	anchors.top: showStepListSearch ? stepSearchBar.bottom : parent.top

    }
    SortFilterProxyModel {
	id: stepSortFilterProxyListModel
	sourceModel: StepListModel {}

	sorters: StringSorter {
	    roleName: "Chair"
	    enabled: true
	}

	filters: AnyOf {
	    RegExpFilter {
		id: studentFirstNameFilterId
		roleName: "Title"
		pattern: stepSearchBar.text
		enabled: true
		caseSensitivity: "CaseInsensitive"
	    }
	    RegExpFilter {
		id: studentLastNameFilterId
		roleName: "Chair"
		pattern: stepSearchBar.text
		enabled: true
		caseSensitivity: "CaseInsensitive"
	    }
	}
    }
}
