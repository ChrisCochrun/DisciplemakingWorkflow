import QtQuick 2.0
import QtQuick.Layouts 1.12
import Felgo 3.0
import QtWebView 1.1


/*

// EXAMPLE USAGE:
// add the following piece of code inside your App { } to display the Login Page

// property to store whether user is logged
property bool userLoggedIn: false

// login page is always visible if user is not logged in
LoginPage {
  z: 1 // show login above actual app pages
  visible: opacity > 0
  enabled: visible
  opacity: userLoggedIn ? 0 : 1 // hide if user is logged in
  onLoginSucceeded: userLoggedIn = true

  Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
}

*/
Page {
	id: loginPage
	title: "Login"

	Navigation {
		NavigationBar {
			leftBarItem: NavigationBarItem {
				IconButton {
					anchors.fill: parent
					icon: IconType.caretleft
					color: Theme.platform === "ios" ? "blue" : "white"
					onClicked: loginWebView.goBack()
				}
			}
		}

		WebView {
			id: loginWebView
			url: "https://microsoft.com"
		}
	}
}
