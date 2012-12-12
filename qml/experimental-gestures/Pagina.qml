import QtQuick 1.1

Rectangle {
    id: item
    width: parent.width
    height: parent.height

    property string text
    property Item nordPage: null
    property Item sudPage: null
    property Item eastPage: null
    property Item westPage: null

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
        if (newState === "up")
        {
            if (sudPage !== null)
            {
                sudPage.changeState ("center")
                state = newState
            }
        }
        else if (newState === "down")
        {
            if (nordPage !== null)
            {
                nordPage.changeState ("center")
                state = newState
            }
        }
        else if (newState === "left")
        {
            if (eastPage !== null)
            {
                eastPage.changeState ("center")
                state = newState
            }
        }
        else if (newState === "right")
        {
            if (westPage !== null)
            {
                westPage.changeState ("center")
                state = newState
            }
        }
        else if (newState === "center")
        {
            state = newState

            if (nordPage !== null)
                nordPage.state = "up"
            if (sudPage !== null)
                sudPage.state = "down"
            if (westPage !== null)
                westPage.state = "left"
            if (eastPage !== null)
                eastPage.state = "right"
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
        }*/
    ]

    Text {
        text: parent.text
        anchors.centerIn : parent
    }
}
