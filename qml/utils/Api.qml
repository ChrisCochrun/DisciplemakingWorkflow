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

    function updateStudent(student) {
        console.log(student.Name)
    }

    function finishActionStep(step, student) {
        console.log(step.Title)
        console.log(step._id)
        console.log(student.Name)
        console.log(student._id)

        var data = JSON.stringify({
            "table_name": "Action Steps",
            "other_table_name": "Students",
            // This is the link id for the current students column
            "link_id": "N9Zx",
            "table_row_id": step._id,
            "other_table_row_id": student._id
        });

        var xhr = new XMLHttpRequest();
        xhr.withCredentials = true;

        /* xhr.addEventListener("readystatechange", function() { */
        /*     if(this.readyState === 4) { */
        /*         console.log(this.responseText); */
        /*     } */
        /* }); */

        xhr.open("DELETE", "https://table.tfcconnection.org/dtable-server/api/v1/dtables/02bcc337-2b09-42c6-ae75-310599e710c6/links/");
        xhr.setRequestHeader("Authorization", "Token " + accessToken);
        xhr.setRequestHeader("Accept", "application/json");
        xhr.setRequestHeader("Content-type", "application/json");

        xhr.send(data);

        /* HttpRequest */
        /*     .del("https://table.tfcconnection.org/dtable-server/api/v1/dtables/02bcc337-2b09-42c6-ae75-310599e710c6/links/") */
        /*     .set("Authorization", "Token " + accessToken) */
        /*     .accept("json") */
        /*     .query({ */
        /*         "table_name": "Action Steps", */
        /*         "other_table_name": "Students", */
        /*         // This is the link id for the current students column */
        /*         "link_id": "N9Zx", */
        /*         "table_row_id": step._id, */
        /*         "other_table_row_id": student._id */
        /*     }) */
        /*     .then( */
        /*         function (res) { */
        /*             console.log(res.status) */
        /*             console.log(JSON.stringify(res.body, null, 4)) */
        /*         } */
        /*     ) */
        HttpRequest
            .post("https://table.tfcconnection.org/dtable-server/api/v1/dtables/02bcc337-2b09-42c6-ae75-310599e710c6/links/")
            .set("Authorization", "Token " + accessToken)
            .accept("json")
            .send({
                "table_name": "Action Steps",
                "other_table_name": "Students",
                // This is the link id for the finished students column
                "link_id": "5UNS",
                "table_row_id": step._id,
                "other_table_row_id": student._id
            })
            .then(
                function (res) {
                    console.log(res.status)
                    console.log(JSON.stringify(res.body, null, 4))
                }
            )
    }
}
