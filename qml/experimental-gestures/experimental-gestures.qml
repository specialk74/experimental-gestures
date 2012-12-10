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
        state: "center"
    }
    Pagina {
        id: swipeB
        text: "Swipe B"
        color: "red"
        state: "up"
    }
    Pagina {
        id: swipeC
        text: "Swipe C"
        color: "yellow"
        state: "down"
    }
    Pagina {
        id: swipeD
        text: "Swipe D"
        color: "blue"
        state: "right"
    }
    Pagina {
        id: swipeE
        text: "Swipe E"
        color: "gray"
        state: "left"
    }

    GestureArea {
        anchors.fill: parent
        focus: true
        property string wichSwipe: "null"

        // Only some of the many gesture properties are shown. See Gesture documentation.

        onTap:
            console.log("tap pos = (",gesture.position.x,",",gesture.position.y,")")
        onTapAndHold:
            console.log("tap and hold pos = (",gesture.position.x,",",gesture.position.y,")")
        onPan:
        {
            console.log("gesture.offset.x: ", gesture.offset.x, "gesture.offset.y: ", gesture.offset.y)
            console.log("gesture.delta.x: ", gesture.delta.x, "gesture.delta.y: ", gesture.delta.y)
            // x positiva -> vs sx
            // y positiva -> vs alto
            if (Math.abs(gesture.offset.x) > 25 || Math.abs(gesture.offset.y) > 25)
            {
                if (Math.abs(gesture.offset.x) > Math.abs(gesture.offset.y))
                {
                    if (gesture.offset.x > 0)
                    {
                        if (swipeA.state == "right")
                            swipeA.x += -gesture.delta.x
                        else if (swipeE.state == "right" && swipeD.state == "center")
                            swipeE.x += -gesture.delta.x
                        else if (swipeD.state == "right" && swipeA.state == "center")
                            swipeD.x += -gesture.delta.x
                    }
                    else
                    {
                        if (swipeA.state == "left")
                            swipeA.x += -gesture.delta.x
                        else if (swipeE.state == "left" && swipeA.state == "center")
                            swipeE.x += -gesture.delta.x
                        else if (swipeD.state == "left" && swipeE.state == "center")
                            swipeD.x += -gesture.delta.x
                    }
                }
            }
            else
            {
                if (gesture.offset.y > 0)
                {
                    if (swipeA.state == "down")
                        swipeA.y += -gesture.delta.y
                    else if (swipeB.state == "down" && swipeC.state == "center")
                        swipeB.y += -gesture.delta.y
                    else if (swipeC.state == "down" && swipeA.state == "center")
                        swipeC.y += -gesture.delta.y
                }
                else
                {
                    if (swipeA.state == "up")
                        swipeA.y += -gesture.delta.y
                    else if (swipeB.state == "up" && swipeA.state == "center")
                        swipeB.y += -gesture.delta.y
                    else if (swipeC.state == "up" && swipeB.state == "center")
                        swipeC.y += -gesture.delta.y
                }
            }
            //console.log("pan delta = (",gesture.delta.x,",",gesture.delta.y,") acceleration = ",gesture.acceleration)
        }
        onPinch:
            console.log("pinch center = (",gesture.centerPoint.x,",",gesture.centerPoint.y,") rotation =",gesture.rotationAngle," scale =",gesture.scaleFactor)
        onSwipe:{
            if (lastAngle !== gesture.swipeAngle)
            {
                // Up
/*
                console.log("swipeA.x: ",swipeA.x," y: ", swipeA.y, " state:",swipeA.state, " z:", swipeA.z)
                console.log("swipeB.x: ",swipeB.x," y: ", swipeB.y, " state:",swipeB.state, " z:", swipeB.z)
                console.log("swipeC.x: ",swipeC.x," y: ", swipeC.y, " state:",swipeC.state, " z:", swipeC.z)
                console.log("swipeD.x: ",swipeD.x," y: ", swipeD.y, " state:",swipeD.state, " z:", swipeD.z)
                console.log("swipeE.x: ",swipeE.x," y: ", swipeE.y, " state:",swipeE.state, " z:", swipeE.z)
*/
                lastAngle = gesture.swipeAngle
                wichSwipe = "null"

                // console.log("swipe angle=",gesture.swipeAngle)
                if ((lastAngle > 45.0) && (lastAngle < (90.0 + 45.0)))
                {
                    // Up
                    if (swipeA.state == "center")
                    {
                        wichSwipe = "up"
                    }
                    else if (swipeB.state == "center")
                    {
                        wichSwipe = "up"
                    }
                    else if (swipeC.state == "center")
                    {
                        wichSwipe = "up"
                    }
                }
                else if ((lastAngle > (90.0 + 45.0)) && (lastAngle < (180.0 + 45.0)))
                {
                    // Left
                    if (swipeA.state == "center")
                    {
                        wichSwipe = "left"
                    }
                    else if (swipeD.state == "center")
                    {
                        wichSwipe = "left"
                    }
                    else if (swipeE.state == "center")
                    {
                        wichSwipe = "left"
                    }
                }
                else if ((lastAngle > (180.0 + 45.0)) && (lastAngle < (270.0 + 45.0)))
                {
                    // Down
                    if (swipeA.state == "center")
                    {
                        wichSwipe = "down"
                    }
                    else if (swipeB.state == "center")
                    {
                        wichSwipe = "down"
                    }
                    else if (swipeC.state == "center")
                    {
                        wichSwipe = "down"
                    }
                }
                else
                {
                    // Right
                    if (swipeA.state == "center")
                    {
                        wichSwipe = "right"
                    }
                    else if (swipeD.state == "center")
                    {
                        wichSwipe = "right"
                    }
                    else if (swipeE.state == "center")
                    {
                        wichSwipe = "right"
                    }
                }

                if (wichSwipe != "null")
                {
                    swipeA.changeState(wichSwipe)
                    swipeB.changeState(wichSwipe)
                    swipeC.changeState(wichSwipe)
                    swipeD.changeState(wichSwipe)
                    swipeE.changeState(wichSwipe)
                }
            }
        }
        onGesture:
            console.log("gesture hot spot = (",gesture.hotSpot.x,",",gesture.hotSpot.y,")")
    }
}
