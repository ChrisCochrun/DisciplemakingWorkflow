import QtQuick 2.0

ListModel {
	id: stepModel

	ListElement {
		name: "Bible study with a Leader."
		category: [
			ListElement {
				name: "Feed"
			}
		]
		identity: false
		walk: false
		talk: false
		feed: true
		clean: false
		chair: "Chair 2"
	}

	ListElement {
		name: "Go on a Mission Trip"
		category: [
			ListElement {
				name: "Walk"
			}
		]
		identity: false
		walk: true
		talk: false
		feed: false
		clean: false
		chair: "Chair 2"
	}

	ListElement {
		name: "Go through Disciplemaker Living Guide with someone in Chair 3"
		category: [
			ListElement {
				name: "Identity"
			}
		]
		identity: true
		walk: false
		talk: false
		feed: false
		clean: false
		chair: "Chair 2"
	}

	ListElement {
		name: "Devo leader in training at Camp"
		category: [
			ListElement {
				name: "Walk"
			}
		]
		identity: false
		walk: true
		talk: false
		feed: false
		clean: false
		chair: "Chair 2"
	}
	ListElement {
		name: "Present the Gospel. (Ready/Repentant)"
		category: [
			ListElement {
				name: "Clean"
			}
		]
		identity: false
		walk: false
		talk: false
		feed: false
		clean: true
		chair: "Chair 1"
	}
	ListElement {
		name: "\"Time With\" a leader and other/younger teens. Examples: Ice Cream outing, movies, camping trip"
		category: [
			ListElement {
				name: "Walk"
			},
			ListElement {
				name: "Talk"
			},
			ListElement {
				name: "Feed"
			}
		]
		identity: false
		walk: true
		talk: true
		feed: true
		clean: false
		chair: "Chair 3"
	}
}
