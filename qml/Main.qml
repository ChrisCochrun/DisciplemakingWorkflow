import Felgo 3.0
import QtQuick 2.13
import "views"
import "models"
import "utils"

App {

    /* licenseKey: "A8D4D09BC876D99B8204303419CAE22A48438029C1315071BFC1664774E0739493C7C56C2D53CF7C4405932ACBB9DEA30F1B7777FC908DF4E57A71D6CA064D1828137EF3D3583D100B2949559CD08944DC2BB331D569C83C60C9FDB59B4E88AB2AA21B9A471F280D204E8130AD8E18EBB7AD1CCAC5E8358BA8D513E48F76B9C2555D9DC98066A035B3A208BA853680098FAA55CADBA18DE5BE9E1D5DD96AAC38BF7DD2BF8818F128377A79FFB4D8E95AFA37E2BCB48FF0856CF89E08D60DCA63B37A4C4BF00E82207AA4690C038085B0AF32835A6E4E0BCF313B3D6FE9951BDD8068A984DE818F76B94CD49A286DD5776642D34E58C885AD2819D615E632607FFDB9219483B1111CBA9A4C5D3047C8867FD8B89D74695E5C501481A86F27A7A4FD47E9F3CD9B8E38EC88DF4353CF6A55" */
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
    property string accessToken: ""

    Api {
        id: restApi
    }

    Component.onCompleted: {
        restApi.getAccessToken()
    }

    // lets setup our model
    StudentStepListModel {
        id: studentStepListModel
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
        /* Component.onCompleted: { */
        /*     if (!isLoggedIn) { */
        /*         mainNavigationStack.push(LoginPage) */
        /*     } */
        /* } */

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
        //              NavigationItem {
        //                      title: qsTr("Login")
        //                      icon: IconType.globe
        //                      NavigationStack {=
        //                              LoginPage {}
        //                      }
        //              }
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
