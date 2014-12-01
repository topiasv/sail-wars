/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
//import QtQuick.Controls 1.0
import Sailfish.Silica 1.0
import "../content/logic.js" as Logic
//import QtSvg 5.3


Page {
    id: page

    property bool passedSplash
    property int castle: 30
    property int fence: 10
    property int bricks: 5
    property int builders: 2
    property int weapons: 5
    property int soldiers: 2
    property int crystals: 5
    property int wizards: 2

    function rand(from, to) {
        return Math.floor(Math.random() * (to - from + 1) + from);
    }

    /*Image {
        id: background
        source:"../content/gfx/background.png"
        anchors.fill:parent
    }*/

    states: [
        State {
            name: "gameOn"
            when: Logic.gameState.gameOver === false
            PropertyChanges { target: castleimg; y: 480; visible: true }
            PropertyChanges { target: build; visible: true }
            PropertyChanges { target: attack; visible: true }
            PropertyChanges { target: magic; visible: true }
            PropertyChanges { target: health; visible: true }
            StateChangeScript { script: console.log("state = gameOn") }
        },

        State {
            name: "gameOver"
            when: Logic.gameState.gameOver === true
            PropertyChanges { target: castleimg; visible: false }
            PropertyChanges { target: build; visible: false }
            PropertyChanges { target: attack; visible: false }
            PropertyChanges { target: magic; visible: false }
            PropertyChanges { target: health; visible: false }
            StateChangeScript { script: console.log("state = gameOver") }
        }

    ]

    FontLoader {
        id: primaryFont
        name: Georgia
    }

    FontLoader {
        id: secondaryFont
        source: "../content/fonts/MTCORSVA.TTF"
    }

    Rectangle {
        id: sky
        anchors.top: parent.top
        width: parent.width
        height: parent.height * 0.75
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#55b6ec" }
            GradientStop { position: 1.0; color: "#3382cb" }
        }
    }

    Image {
        id: castleimg
        source: "../content/gfx/castle-blue.png"
        x: parent.width/2 - 310/2
        y: parent.height - ground.height - castle * 5 - 36
        visible: false
    }

    Repeater {
        model: 4
        delegate: Image {
            id: cloud
            source:"../content/gfx/cloud.png"
            y: rand(0,150)

            NumberAnimation on x {
                 id: cloudAnimation
                 loops: Animation.Infinite
                 from: -128
                 to: 668
                 duration: rand(20000,40000) + rand(0,10000)
            }
        }
    }

    Repeater {
        model: 4
        delegate: Image {
            id: cloud2
            source:"../content/gfx/cloud.png"
            transform: Rotation { axis { x: 0; y: 1; z: 0 } angle: 180 }
            y: rand(50,200)

            NumberAnimation on x {
                 id: cloudAnimation2
                 loops: Animation.Infinite
                 from: -512
                 to: 668
                 duration: rand(20000,40000) + rand(0,10000)
            }
        }
    }

    Rectangle {
        id: ground
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height * 0.25
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#5fdb50" }
            GradientStop { position: 1.0; color: "#228f1d" }
        }
    }

    Rectangle {
        id: grass
        anchors.top: sky.bottom
        width: parent.width
        height: parent.height * 0.01
        color: "#006600"
    }

    Image {
        id: title
        source: "../content/gfx/cwtitle.png"
        x: 20
        y: 10
        sourceSize.width: parent.width - 40
        sourceSize.height: width * 0.26

        SmoothedAnimation on y {
            to: 200
            duration: 3000
            velocity: 1
            easing.type: Easing.OutInQuad
        }
    }

    Rectangle {
        id: build
        width: 100
        height: 100
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10
        visible: false

        color: "#fe7756"
        border.color: "#a90101"
        border.width: 10
        radius: 20

        Image {
            id: brick
            source: "../content/gfx/brick.png"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked:
                castle += 5
        }
    }

    Rectangle {
        id: attack
        width: 100
        height: 100
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: build.bottom
        anchors.topMargin: 10
        visible: false

        color: "#66ff57"
        border.color: "#006600"
        border.width: 10
        radius: 20

        Image {
            id: weapon
            source: "../content/gfx/weapon.png"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked:
                Logic.health.castle -= 5
        }
    }

    Rectangle {
        id: magic
        width: 100
        height: 100
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: attack.bottom
        anchors.topMargin: 10
        visible: false

        color: "#02b3fd"
        border.color: "#003399"
        border.width: 10
        radius: 20
    }

    Rectangle {
        id: health
        width: 100
        height: 100
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: magic.bottom
        anchors.topMargin: 10
        visible: false

        color: "#666666"
        border.color: "#000000"
        border.width: 10
        radius: 20

        Text {
            text: parent.castle
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: menuButton
        width: 75
        height: 75
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 10

        color: "#d8a26b"
        border.color: "#cc8c38"
        border.width: 10
        radius: 20

        MouseArea {
            anchors.fill: parent
            onClicked:
                if(startMenu.visible == true)
                    startMenu.visible = false
                else
                    startMenu.visible = true
        }
    }

    Rectangle {
        id: startMenu

        width: 300
        height: 300
        color: "#d8a26b"
        border.color: "#cc8c38"
        border.width: 10
        radius: 20
        anchors.centerIn: parent
        visible: true

        NumberAnimation on opacity {
            id: menuAnimation
            from: 0.00
            to: 1.00
            duration: 3000
        }

        Column {
            anchors.horizontalCenter: parent.Center
            Text {
                anchors.horizontalCenter: startMenu.Center
                text: "Menu"
                font.family: secondaryFont.name
            }

            Button {
                text: "New Game"
                onClicked: { console.log(Logic.startGame()); startMenu.visible = false; title.visible = false; page.state = "gameOn"; }
                anchors.horizontalCenter: startMenu.Center
            }

            Button {
                text: "Close"
                onClicked: { console.log(Logic.getGameState()); }
                anchors.horizontalCenter: startMenu.Center
            }
        }
    }
}
