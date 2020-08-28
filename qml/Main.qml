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
	property var stepJsonData: []
	property var studentStepJsonData: []
	property var selectedStudent: null

	Component.onCompleted: {

		//Get students from SharePoint
		  HttpRequest.get(
				  "https://prod-15.northcentralus.logic.azure.com:443/workflows/1e4ac14513d949e0b46908d2a1135cc4/triggers/request/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Frequest%2Frun&sv=1.0&sig=YTHqWy2x2Jw9vW54KFsfFAOFrtMWFKfVCACLHlZJWmw").then(
						function (res) {
							  console.log("Beginning logging request of students... ")
							  console.log(res.status)
							  //console.log(JSON.stringify(res.header, null, 4))
							  //console.log(JSON.stringify(res.body, null, 4))
							  studentJsonDataFetched(res.body)
						}).catch(function (err) {
							  console.log(err.message)
							  console.log(err.response)
						})

		//Get steps from SharePoint
		  HttpRequest.get(
				  "https://prod-08.northcentralus.logic.azure.com/workflows/9c3ae74f0be6447ea100d9943c5c8f9f/triggers/request/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Frequest%2Frun&sv=1.0&sig=SLym0AsPf4wi8Jzz7qnvf7gT1wFbamVvhsD79ZJKLaM").then(
						function (res) {
							  console.log("Beginning logging request of steps... ")
							  console.log(res.status)
							  console.log(JSON.stringify(res.header, null, 4))
							  console.log(JSON.stringify(res.body, null, 4))
							  stepJsonDataFetched(res.body)
						}).catch(function (err) {
							  console.log(err.message)
							  console.log(err.response)
						})

		//Get StudentStep List from SharePoint
		  HttpRequest.get(
				  "https://prod-14.northcentralus.logic.azure.com:443/workflows/d17289c2621e40368acfe606eba67c1b/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=YUArtnSgsaBxk0PTX4DRqrwAAmQZxwWQkGZZTHm9JYU").then(
						function (res) {
							  console.log("Beginning logging request of StudentSteps... ")
							  console.log(res.status)
							  /* console.log(JSON.stringify(res.header, null, 4)) */
							  /* console.log(JSON.stringify(res.body, null, 4)) */
							  studentStepJsonDataFetched(res.body)
						}).catch(function (err) {
							  console.log(err.message)
							  console.log(err.response)
						})



	}

	/* Ensure icons are used in tabbar */
	onInitTheme: {
		Theme.tabBar.showIcon = true
	}

	Navigation {
		id: mainNavigationStack
		navigationMode: navigationModeTabsAndDrawer
		tabPosition: Qt.BottomEdge

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
	/* Component that loads the detail of student when student is selected */
	Component {
		id: studentDetailPageComponent
		StudentDetailPage {
			id: studentDetailPageId
			title: selectedStudentName
		}
	}

	// Move student json data into studentJsonData so it's attached to JsonListModel
	function studentJsonDataFetched(jsonData) {
		studentJsonData = jsonData
	}

	// Move json data into studentJsonData so it's attached to JsonListModel
	function stepJsonDataFetched(jsonData) {
		stepJsonData = jsonData
	}

	// Move json data into studentJsonData so it's attached to JsonListModel
	function studentStepJsonDataFetched(jsonData) {
		studentStepJsonData = jsonData
	}
}
