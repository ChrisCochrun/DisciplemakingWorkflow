import QtQuick 2.0
import Felgo 3.0
import "../models"

Item {
    id: restApi


    function getAccessToken() {

        HttpRequest
            .get("https://table.tfcconnection.org/api/v2.1/dtable/app-access-token/")
            .set("Authorization", "Token 79466f33ae406153f537aab1194ab5f324760a2e")
            .then(
                function (res) {
                    var token = res.body.access_token
                    accessToken = token
                    getStudents()
                    getSteps()
                }
            )
    }

    function getStudents() {
        console.log("Getting students")
        HttpRequest
            .get("https://table.tfcconnection.org/dtable-server/api/v1/dtables/02bcc337-2b09-42c6-ae75-310599e710c6/rows/?table_name=Students&view_id=0000")
            .set("Authorization", "Token " + accessToken)
            .then(
                function (res) {
                    var rows = res.body.rows
                    /* console.log(JSON.stringify(rows, null, 4)) */
                    studentJsonDataFetched(rows)
                }
            )
    }
    // Httprequest to get data

    function getSteps() {
        console.log("Gettings steps")
        HttpRequest
            .get("https://table.tfcconnection.org/dtable-server/api/v1/dtables/02bcc337-2b09-42c6-ae75-310599e710c6/rows/?table_name=Action Steps&view_id=0000")
            .set("Authorization", "Token " + accessToken)
            .then(
                function (res) {
                    var rows = res.body.rows
                    stepJsonDataFetched(rows)
                    console.log(rows[1].Title)
                }
            )

    }

    // Move student json data into studentJsonData so it's attached to JsonListModel
    function studentJsonDataFetched(jsonData) {
        studentJsonData = jsonData
    }

    // Move json data into stepJsonData so it's attached to JsonListModel
    function stepJsonDataFetched(jsonData) {
        stepJsonData = jsonData
        /* console.log(Json.stringify(jstepJsonData, null, 4)) */
    }
}
