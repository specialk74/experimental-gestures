import QtQuick 1.1

Rectangle {
    id: item
    //anchors.fill: parent
    width: parent.width
    height: parent.height

    property string text

    states: [
        State {
            name: "up"
            PropertyChanges {
                target: item
                y: -item.height
            }
        },
        State {
            name: "down"
            PropertyChanges {
                target: item
                y: item.height
            }
        },
        State {
            name: "left"
            PropertyChanges {
                target: item
                x: -item.width
            }
        },
        State {
            name: "right"
            PropertyChanges {
                target: item
                x: item.width
            }
        },
        State {
            name: "center"
            PropertyChanges {
                target: item
                x: 0
                y: 0
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 2000 }
    }

    Text {
        text: parent.text
        anchors.centerIn : parent
    }
}
