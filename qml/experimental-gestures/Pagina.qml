import QtQuick 1.1

Rectangle {
    id: item
    width: parent.width
    height: parent.height

    property string text
    property Item upPage: null
    property Item downPage: null
    property Item rightPage: null
    property Item leftPage: null

    states: [
        State {
            name: "up"
            PropertyChanges {
                target: item
                y: -item.height
                z: 1
            }
        },
        State {
            name: "down"
            PropertyChanges {
                target: item
                y: item.height
                z: 1
            }
        },
        State {
            name: "left"
            PropertyChanges {
                target: item
                x: -item.width
                z: 1
            }
        },
        State {
            name: "right"
            PropertyChanges {
                target: item
                x: item.width
                z: 1
            }
        },
        State {
            name: "center"
            PropertyChanges {
                target: item
                x: 0
                y: 0
                z: 0
            }
        }
    ]

    function changeState (newState)
    {
//        console.log (text, state, " -> ", newState)
        if (newState === "up")
        {
            if (state == "up")
                state = "down"
            else if (state == "center")
                state = "up"
            else if (state == "down")
                state = "center"
        }
        else if (newState === "down")
        {
            if (state == "down")
                state = "up"
            else if (state == "center")
                state = "down"
            else if (state == "up")
                state = "center"
        }
        else if (newState === "left")
        {
            if (state == "left")
                state = "right"
            else if (state == "center")
                state = "left"
            else if (state == "right")
                state = "center"
        }
        else
        {
            if (state == "right")
                state = "left"
            else if (state == "center")
                state = "right"
            else if (state == "left")
                state = "center"
        }
    }

    transitions: [
       Transition {
           from: "center";
           PropertyAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 2000 }
       }
/*
        Transition {
            to: "center"
            PropertyAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 2000 }
        }
            */
    ]

    Text {
        text: parent.text
        anchors.centerIn : parent
    }
}
