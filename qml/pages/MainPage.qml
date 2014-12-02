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
//import "../content/logic.js" as Logic
//import QtSvg 5.3


Page {
    id: page

    function rand(from, to) {
        return Math.floor(Math.random() * (to - from + 1) + from);
    }

    states: [
        State {
            name: "gameOn"
            PropertyChanges { target: castleimg; y: 480; visible: true }
            PropertyChanges { target: build; visible: true }
            PropertyChanges { target: attack; visible: true }
            PropertyChanges { target: magic; visible: true }
            PropertyChanges { target: health; visible: true }
            PropertyChanges { target: menu; visible: false }
            PropertyChanges { target: title; visible: false }
            StateChangeScript { script: console.log("state = gameOn") }
        },

        State {
            name: "gameOver"
            PropertyChanges { target: castleimg; visible: false }
            PropertyChanges { target: build; visible: false }
            PropertyChanges { target: attack; visible: false }
            PropertyChanges { target: magic; visible: false }
            PropertyChanges { target: health; visible: false }
            PropertyChanges { target: menu; visible: true }
            PropertyChanges { target: title; visible: true }
            StateChangeScript { script: console.log("state = gameOver") }
        }

    ]

    /*Image {
        id: background
        source:"../content/gfx/background.png"
        anchors.fill:parent
    }*/

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

    Image {
        id: castleimg
        source: "../content/gfx/castle-blue.png"
        x: parent.width/2 - 310/2
        y: parent.height - ground.height - game.castle * 5 - 36
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
                game.buildCastle(5)
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
                game.attack(5)
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
            text: "" + game.castle
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
                action.toggleMenu()
        }
    }

    Rectangle {
        id: menu

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
                anchors.horizontalCenter: mMenu.Center
                text: "Menu"
                font.family: secondaryFont.name
            }

            Button {
                text: "New Game"
                onClicked: { action.startGame() }
                anchors.horizontalCenter: mMenu.Center
            }
        }
    }


    QtObject {
        id: game
        property var builders
        property var bricks
        property var soldiers
        property var weapons
        property var sorcerers
        property var crystals
        property var castle
        property var fence

        function attack(attack) {
            /*game.fence -= attack
            if (game.fence <= 0) {
                var nextAttack = abs(game.fence)
                game.fence = 0
                game.castle -= nextAttack
                castleimg.y -= nextAttack * 5
                if (game.castle <= 0) {
                    action.endGame()
                }
            }*/
            game.castle -= attack
            if (game.castle < 0) {
                action.endGame()
            }
            castleimg.y = parent.height - ground.height - game.castle * 5 - 36
        }

        function buildCastle(build) {

            game.castle += build

            if (game.castle > 100) {
                action.endGame()
            }
            castleimg.y = parent.height - ground.height - game.castle * 5 - 36
        }

        function buildWall() {

        }

        function recruit() {

        }

        function school() {

        }

        function sorcerer() {

        }
    }

    QtObject {
        id: action

        function startGame() {
            page.state = "gameOn"
            game.builders = 2
            game.bricks = 5
            game.soldiers = 2
            game.weapons = 5
            game.sorcerers = 2
            game.crystals = 5
            game.castle = 30
            game.fence = 10

            castleimg.y = page.height - ground.height - game.castle * 5 - 36
        }

        function endGame() {
            page.state = "gameOver"
        }

        function turn() {

        }

        function toggleMenu() {
            if(menu.visible == true)
                menu.visible = false
            else
                menu.visible = true
        }
    }
}
