import Felgo 3.0
import QtQuick 2.12
import "views"
import "models"

App {

	// You get free licenseKeys from https://felgo.com/licenseKey
	// With a licenseKey you can:
	//  * Publish your games & apps for the app stores
	//  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
	//  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
	//licenseKey: "<generate one from https://felgo.com/licenseKey>"
	property string selectedStudentName: ""
	property bool showListSearch: false
	property bool isLoggedIn: false
	property bool onStepsPage: false
	property var studentJsonData: []
  property var selectedStudent: null


	onInitTheme: {
		Theme.tabBar.showIcon = true
	}

	Navigation {
		id: mainNavigationStack
		navigationMode: navigationModeTabsAndDrawer
		tabPosition: Qt.BottomEdge

		Component.onCompleted: {
			if (!isLoggedIn) {
				mainNavigationStack.push(LoginPage)
			}
		}

		NavigationItem {
			//Student List page with navigation stack and search icon
			title: qsTr("Student List")
			icon: IconType.users
			showInDrawer: false
			NavigationStack {
				id: studentNavigationStack
				splitView: tablet

				StudentListView {
					id: studentListPageId
				}
			}
			onSelected: onStepsPage = false
		}
		NavigationItem {
			//Steps list page
			title: qsTr("Steps")
			icon: IconType.tasks
			showInDrawer: false
			NavigationStack {
				StepsListView {}
			}
			onSelected: onStepsPage = true
		}
		//		NavigationItem {
		//			title: qsTr("Login")
		//			icon: IconType.globe
		//			NavigationStack {
		//				LoginPage {}
		//			}
		//		}
	}
	Component {
		id: studentDetailPageComponent
		StudentDetailPage {
			id: studentDetailPageId
			title: selectedStudentName
		}
	}

	// Move json data into studentJsonData so it's attached to JsonListModel
	function studentJsonDataFetched(jsonData) {
		studentJsonData = jsonData
	}
}
