import QtQuick 2.0
import Felgo 3.0
import "../utils"

Item {

    property var steps: []
    property var stepDetails: ({})

    Storage {
	id: cache
    }

    Api {
	id: api
    }

    function getStep(success, err){

    }

}
