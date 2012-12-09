/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.0
import Qt.labs.gestures 1.0

Rectangle {
    id: rect
    width: 600
    height: 400
    property real lastAngle: 0.0


    Pagina {
        id: swipeA
        text: "Swipe A"
        color: "green"
    }
    Pagina {
        id: swipeB
        text: "Swipe B"
        color: "red"
//        anchors.bottom: swipeA.top
    }
    Pagina {
        id: swipeC
        text: "Swipe C"
        color: "yellow"
//        anchors.top: swipeA.bottom
    }
    Pagina {
        id: swipeD
        text: "Swipe D"
        color: "blue"

//        anchors.left: swipeA.right
    }
    Pagina {
        id: swipeE
        text: "Swipe E"
        color: "gray"

//        anchors.right: swipeA.left
    }
    Pagina {
        id: nullPage
    }


    GestureArea {
        anchors.fill: parent
        focus: true

        // Only some of the many gesture properties are shown. See Gesture documentation.

        onTap:
            console.log("tap pos = (",gesture.position.x,",",gesture.position.y,")")
        onTapAndHold:
            console.log("tap and hold pos = (",gesture.position.x,",",gesture.position.y,")")
        onPan:
        {
            if (gesture.offset.x > gesture.offset.y)
                swipeA.x += -gesture.delta.x
            else
                swipeA.y += -gesture.delta.y
            //console.log("pan delta = (",gesture.delta.x,",",gesture.delta.y,") acceleration = ",gesture.acceleration)
        }
        onPinch:
            console.log("pinch center = (",gesture.centerPoint.x,",",gesture.centerPoint.y,") rotation =",gesture.rotationAngle," scale =",gesture.scaleFactor)
        onSwipe:{
            if (lastAngle !== gesture.swipeAngle)
            {
                console.log("swipeA.x: ",swipeA.x," swipeA.y: ", swipeA.y)
                console.log("swipeB.x: ",swipeB.x," swipeB.y: ", swipeB.y)
                console.log("swipeC.x: ",swipeC.x," swipeC.y: ", swipeC.y)
                lastAngle = gesture.swipeAngle
                // console.log("swipe angle=",gesture.swipeAngle)
                if ((lastAngle > 45.0) && (lastAngle < (90.0 + 45.0)))
                {                    
                    if (swipeA.state == "center" || swipeA.state == "")
                    {
                        //swipeA.visible = false
                        //swipeC.visible = true

                        // swipeC.state = "up"
                        //swipeC.y = 0
                        // swipeA.y = -parent.height
                        console.log("swipeA.state = up")
                        swipeA.state = "up"
                        swipeC.state = "center"
                    }
                    else if (swipeB.state == "center" || swipeB.state == "")
                    {
                        //swipeB.visible = false
                        //swipeA.visible = true

                        //swipeA.state = "up"
                        console.log("swipeB.state = up")
                        swipeB.state = "up"
                        swipeA.state = "center"
                    }
                    else if (swipeC.state == "center" || swipeC.state == "")
                    {
                        // swipeC.visible = false
                        // swipeB.visible = true

                        // swipeB.state = "up"
                        //swipeB.x = 0
                        //swipeB.y = 0
                        console.log("swipeC.state = up")
                        swipeC.state = "up"
                        swipeB.state = "center"
                    }
                }
                else if ((lastAngle > (90.0 + 45.0)) && (lastAngle < (180.0 + 45.0)))
                {
                    console.log("swipe left")
                    if (swipeA.x == 0 && swipeA.y == 0)
                    {
                        //swipeA.visible = false
                        //swipeD.visible = true

                        swipeA.state = "left"
                    }
                    else if (swipeD.x == 0 && swipeD.y == 0)
                    {
                        //swipeD.visible = false
                        //swipeE.visible = true

                        swipeD.state = "left"
                    }
                    else if (swipeE.x == 0 && swipeE.y == 0)
                    {
                        //swipeE.visible = false
                        //swipeA.visible = true

                        swipeE.state = "left"
                    }
                }
                else if ((lastAngle > (180.0 + 45.0)) && (lastAngle < (270.0 + 45.0)))
                {
                    console.log("swipe down")
                    if (swipeA.x == 0 && swipeA.y == 0)
                    {
                        //swipeA.visible = false
                        //swipeB.visible = true

                        swipeA.state = "down"
                    }
                    else if (swipeB.x == 0 && swipeB.y == 0)
                    {
                        //swipeB.visible = false
                        //swipeC.visible = true

                        swipeB.state = "down"
                    }
                    else if (swipeC.x == 0 && swipeC.y == 0)
                    {
                        //swipeC.visible = false
                        //swipeA.visible = true

                        swipeC.state = "down"
                    }
                }
                else
                {
                    console.log("swipe right")
                    if (swipeA.x == 0 && swipeA.y == 0)
                    {
                        //swipeA.visible = false
                        //swipeE.visible = true

                        swipeA.state = "right"
                    }
                    else if (swipeD.x == 0 && swipeD.y == 0)
                    {
                        //swipeD.visible = false
                        //swipeA.visible = true

                        swipeD.state = "right"
                    }
                    else if (swipeE.x == 0 && swipeE.y == 0)
                    {
                        //swipeE.visible = false
                        //swipeD.visible = true

                        swipeE.state = "right"
                    }
                }

            }
        }
        onGesture:
            console.log("gesture hot spot = (",gesture.hotSpot.x,",",gesture.hotSpot.y,")")
    }
}
