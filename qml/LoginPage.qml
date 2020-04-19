import QtQuick 2.0
import QtQuick.Layouts 1.12
import Felgo 3.0
import QtWebKit 3.0


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

	NavigationBar {
		leftBarItem: NavigationBarItem {
			IconButton {
				anchors.fill: parent
				icon: IconType.caretleft
				color: Theme.platform === "ios" ? "blue" : "white"
				onClicked: mainNavigationStack.pop()
			}
		}
	}

	WebView {
		url: "https://login.microsoftonline.com/e47b9bb7-1701-400e-9cbd-195c9cfda2c2/oauth2/v2.0/authorize?client_id=314d38d1-2be6-4592-9de7-803eda22a3ea&response_type=code&redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient&response_mode=query&scope=offline_access%20user.read%20profile%20sites.manage.all%20sites.readwrite.all"
	}
}
