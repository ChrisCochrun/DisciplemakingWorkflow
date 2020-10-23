import Felgo 3.0
import QtQuick 2.13
import "views"
import "models"
import "utils"

App {

	// You get free licenseKeys from https://felgo.com/licenseKey
	// With a licenseKey you can:
	//  * Publish your games & apps for the app stores
	//  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
	//  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
	//licenseKey: "<generate one from https://felgo.com/licenseKey>"
	property string selectedStudentName: ""
    property string selectedStepTitle: ""
    property bool showListSearch: false
	property bool isLoggedIn: false
	property bool onStepsPage: false
	property var selectedStudent: null
    property int selectedChair: null
    property var selectedStep: null
    property var studentStepJsonData: []
    property var studentJsonData: []
    property var stepJsonData: []

    Api {
        id: restApi
    }

	Component.onCompleted: {
            restApi.getStudentData()
            restApi.getStepData()
	}

	/* Ensure icons are used in tabbar */
	onInitTheme: {
		Theme.tabBar.showIcon = true
	}

	Navigation {
		id: mainNavigationStack
        navigationMode: navigationModeTabsAndDrawer
		tabPosition: Qt.BottomEdge
        drawerMinifyEnabled: true

	  /* check to see if logged in, if not open login page */
		Component.onCompleted: {
			if (!isLoggedIn) {
				mainNavigationStack.push(LoginPage)
			}
		}

		NavigationItem {
			//Student List page with navigation stack and search icon - App starts on this page for now
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
                StepsListView {
                    id: stepListPageId
                }
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
	/* Component that loads the detail of student when student is selected */
	Component {
		id: studentDetailPageComponent
		StudentDetailPage {
			id: studentDetailPageId
			title: selectedStudentName
		}
	}

    /* Component that loads the detail of student when student is selected */
    Component {
        id: stepDetailPageComponent
        StepDetailPage {
            id: stepDetailPageId
            title: selectedStepTitle
        }
    }

}
