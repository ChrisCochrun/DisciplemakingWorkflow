import Felgo 3.0
import QtQuick 2.0

App {

	// You get free licenseKeys from https://felgo.com/licenseKey
	// With a licenseKey you can:
	//  * Publish your games & apps for the app stores
	//  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
	//  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
	//licenseKey: "<generate one from https://felgo.com/licenseKey>"
	property string selectedStudentName: ""
	property bool showListSearch: false

	Component.onCompleted: {
		HttpRequest.get("http://httpbin.org/get").timeout(5000).then(
					function (res) {
						console.log("Beginning logging request... ")
						console.log(res.status)
						console.log(JSON.stringify(res.header, null, 4))
						console.log(JSON.stringify(res.body, null, 4))
					}).catch(function (err) {
						console.log(err.message)
						console.log(err.response)
					})
	}

	TabControl {
		tabPosition: Qt.BottomEdge
		NavigationItem {
			title: qsTr("Student List")
			icon: IconType.home
			NavigationStack {
				id: studentNavigationStack
				splitView: tablet

				StudentListView {
					id: studentListPageId

					rightBarItem: NavigationBarItem {
						IconButton {
							anchors.fill: parent
							icon: IconType.search
							color: Theme.platform === "ios" ? "blue" : "white"
							selectedIcon: IconType.times
							toggle: true
							onToggled: showListSearch = !showListSearch
						}
					}
				}
			}
		}
		NavigationItem {
			title: qsTr("Steps")
			icon: IconType.tasks
			NavigationStack {
				StepsListView {}
			}
		}
	}
	Component {
		id: studentDetailPageComponent
		StudentDetailPage {
			id: studentDetailPageId
			title: selectedStudentName
		}
	}
}
