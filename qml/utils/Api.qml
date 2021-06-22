import QtQuick 2.0
import Felgo 3.0
import "../models"

Item {
    id: restApi

    // Httprequest to get data
    function getStudentStepData() {
        /* setSelectedChair(selectedChair) */

        console.log("currentChair is " + selectedChair)
        console.log("currentStudent is " + selectedStudent.FullName)
        console.log("currentStudent id " + selectedStudent.ID)

        /* studentStepListModel.clear() */

        //Get StudentStep List from SharePoint
        HttpRequest.get(
            "https://prod-14.northcentralus.logic.azure.com:443/workflows/d17289c2621e40368acfe606eba67c1b/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=YUArtnSgsaBxk0PTX4DRqrwAAmQZxwWQkGZZTHm9JYU" + "&Student=" + selectedStudent.ID)
            .then(
                function (res) {
                    /* console.log("Beginning logging request of StudentSteps... ") */
                    /* console.log("Logging response status is: " + res.status) */
                    /* console.log(JSON.stringify(res.header, null, 4)) */
                    /* console.log(JSON.stringify(res.body, null, 4)) */
                    studentStepJsonDataFetched(res.body)
                }).catch(function (err) {
                    console.log(err.message)
                    console.log(err.response)
                })
    }

    function getStudentData() {
        //Get students from SharePoint
          HttpRequest.get(
                  "https://prod-15.northcentralus.logic.azure.com:443/workflows/1e4ac14513d949e0b46908d2a1135cc4/triggers/request/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Frequest%2Frun&sv=1.0&sig=YTHqWy2x2Jw9vW54KFsfFAOFrtMWFKfVCACLHlZJWmw").then(
                        function (res) {
                            /* console.log("Beginning logging request of students... ") */
                            /* console.log(res.status) */
                            //console.log(JSON.stringify(res.header, null, 4))
                            //console.log(JSON.stringify(res.body, null, 4))
                            studentJsonDataFetched(res.body)
                        }).catch(function (err) {
                            console.log(err.message)
                            console.log(err.response)
                        })
    }

    function getStepData() {
        //Get steps from SharePoint
          HttpRequest.get(
                  "https://prod-08.northcentralus.logic.azure.com/workflows/9c3ae74f0be6447ea100d9943c5c8f9f/triggers/request/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Frequest%2Frun&sv=1.0&sig=SLym0AsPf4wi8Jzz7qnvf7gT1wFbamVvhsD79ZJKLaM").then(
                        function (res) {
                            /* console.log("Beginning logging request of steps... ") */
                            /* console.log(res.status) */
                            /* console.log(JSON.stringify(res.header, null, 4)) */
                            /* console.log(JSON.stringify(res.body, null, 4)) */
                            stepJsonDataFetched(res.body)
                        }).catch(function (err) {
                              console.log(err.message)
                              console.log(err.response)
                        })
    }

    // Move json data into studentStepJsonData so it's attached to JsonListModel
    function studentStepJsonDataFetched(jsonData) {
        studentStepListModel.steps = jsonData
        console.log("Adding JsonData to StudentStepJsonData")
	/* console.log(JSON.stringify(jsonData, null, 4)) */
    }

    // Move student json data into studentJsonData so it's attached to JsonListModel
    function studentJsonDataFetched(jsonData) {
        studentJsonData = jsonData
    }

    // Move json data into stepJsonData so it's attached to JsonListModel
    function stepJsonDataFetched(jsonData) {
        stepJsonData = jsonData
    }
}
