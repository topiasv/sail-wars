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

    property var globalMargins: page.height * 0.01
    property var castle

    function rand(from, to) {
        return Math.floor(Math.random() * (to - from + 1) + from);
    }

    FontLoader {
        id: primaryFont
        name: Georgia
    }

    FontLoader {
        id: secondaryFont
        source: "../content/fonts/MTCORSVA.TTF"
    }

    /*****************STATES*****************/

    states: [
        State {
            name: "gameOn"
            PropertyChanges { target: castleimg; y: 480; visible: true }
            PropertyChanges { target: wall; visible: true }
            PropertyChanges { target: stats; visible: true }
            PropertyChanges { target: menu; visible: false }
            PropertyChanges { target: title; visible: false }
            StateChangeScript { script: console.log("state = gameOn") }
        },

        State {
            name: "gameOver"
            PropertyChanges { target: castleimg; visible: false }
            PropertyChanges { target: wall; visible: false }
            PropertyChanges { target: stats; visible: false }
            PropertyChanges { target: menu; visible: true }
            PropertyChanges { target: title; visible: true }
            StateChangeScript { script: console.log("state = gameOver") }
        }

    ]

    /**************BACKGROUNDS***************/

    Rectangle {
        id: sky
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#3382cb" }
            GradientStop { position: 1.0; color: "#55b6ec" }
        }
    }

    Rectangle {
        id: ground
        anchors.bottom: parent.bottom
        width: parent.width
        height: parent.height * 0.24
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#5fdb50" }
            GradientStop { position: 1.0; color: "#228f1d" }
        }
    }

    Rectangle {
        id: grass
        anchors.bottom: ground.top
        width: parent.width
        height: parent.height * 0.01
        z: 1000
        color: "#006600"
    }

    /*************PLAYER GRAPHICS************/

    /*****************MODELS*****************/

    ListModel {
        id: castleModel
        dynamicRoles: true
        Component.onCompleted: {
            castleModel.append({castleSource: "../content/gfx/castle-blue.png",
                                wallPosX: page.width * 0.875,
                                statModel: blueStatModel,
                                player: blue.name,
                                cloudRotation: 0,
                                cloudStart: -page.width*0.95,
                                cloudEnd: page.width*2.24,
                                cloudY1: 0,
                                cloudY2: page.height * 0.20,
                                deckPic: "../content/cards/BlueBack.png",
                                lastPlayed: blue.lastPlayed
            })
            castleModel.append({castleSource: "../content/gfx/castle-red.png",
                                wallPosX: page.width * 0.125,
                                statModel: redStatModel,
                                player: red.name,
                                cloudRotation: 1,
                                cloudStart: -page.width*1.24,
                                cloudEnd: page.width*1.24,
                                cloudY1: page.height * 0.10,
                                cloudY2: page.height * 0.30,
                                deckPic: "../content/cards/RedBack.png",
                                lastPlayed: red.lastPlayed
            })
        }
    }

    ListModel {
        id: blueStatModel
        dynamicRoles: true
        Component.onCompleted: {

            blueStatModel.append ({
                baseColor: "#fe7756",
                borderColor: "#a90101",
                firstImg: "../content/gfx/brick.png",
                firstStat: blue.builders,
                secondImg: "../content/gfx/brick.png",
                secondStat: blue.bricks
            })
            blueStatModel.append ({
                baseColor: "#66ff57",
                borderColor: "#006600",
                firstImg: "../content/gfx/weapon.png",
                firstStat: blue.soldiers,
                secondImg: "../content/gfx/weapon.png",
                secondStat: blue.weapons
            })
            blueStatModel.append ({
                baseColor: "#02b3fd",
                borderColor: "#003399",
                firstImg: "../content/gfx/crystal.png",
                firstStat: blue.sorcerers,
                secondImg: "../content/gfx/crystal.png",
                secondStat: blue.crystals
            })
            blueStatModel.append ({
                baseColor: "#666666",
                borderColor: "#000000",
                firstImg: "../content/gfx/brick.png",
                firstStat: blue.castle,
                secondImg: "../content/gfx/brick.png",
                secondStat: blue.fence
            })
        }
    }

    ListModel {
        id: redStatModel
        dynamicRoles: true
        Component.onCompleted: {

            redStatModel.append ({
                baseColor: "#fe7756",
                borderColor: "#a90101",
                firstImg: "../content/gfx/brick.png",
                firstStat: red.builders,
                secondImg: "../content/gfx/brick.png",
                secondStat: red.bricks
            })
            redStatModel.append ({
                baseColor: "#66ff57",
                borderColor: "#006600",
                firstImg: "../content/gfx/weapon.png",
                firstStat: red.soldiers,
                secondImg: "../content/gfx/weapon.png",
                secondStat: red.weapons
            })
            redStatModel.append ({
                baseColor: "#02b3fd",
                borderColor: "#003399",
                firstImg: "../content/gfx/crystal.png",
                firstStat: red.sorcerers,
                secondImg: "../content/gfx/crystal.png",
                secondStat: red.crystals
            })
            redStatModel.append ({
                baseColor: "#666666",
                borderColor: "#000000",
                firstImg: "../content/gfx/brick.png",
                firstStat: red.castle,
                secondImg: "../content/gfx/brick.png",
                secondStat: red.fence
            })
        }
    }

    /******************VIEWS*****************/

    ListView {
        width: parent.width
        height: parent.height
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal

        model: castleModel
        delegate:

        Rectangle {
            height: page.height
            width: page.width
            color: "#000000ff"

            Image {
                id: wall
                source: "../content/gfx/wall.png"
                x: wallPosX
                y: page.height - ground.height - grass.height - 10 * 5
                visible: true
            }

            Image {
                id: castleimg
                source: castleSource
                anchors.horizontalCenter: parent.horizontalCenter
                height: page.height * 0.725
                fillMode: Image.PreserveAspectFit
                y: parent.height - ground.height - grass.height - 100 * 5 - 36 // 30 * 5
                z: 100
                visible: true
            }


            Repeater {
                model: 4
                delegate: Image {
                    id: cloud
                    source:"../content/gfx/cloud.png"
                    transform: Rotation { axis { x: 0; y: cloudRotation; z: 0 } angle: 180 }
                    y: rand(cloudY1,cloudY2)

                    NumberAnimation on x {
                         id: cloudAnimation
                         loops: Animation.Infinite
                         from: cloudStart
                         to: cloudEnd
                         duration: rand(30000,50000) + rand(0,10000)
                    }
                }
            }

            Rectangle {
                id: cards
                y: ground.y
                width: ground.width
                height: ground.height
                z: 1000
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#5fdb50" }
                    GradientStop { position: 1.0; color: "#228f1d" }
                }

                Image {
                    id: deck
                    height: parent.height * 0.85
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.horizontalCenter
                    anchors.margins: parent.height * 0.01
                    smooth: true
                    source: deckPic
                }

                Image {
                    id: played
                    height: parent.height * 0.85
                    fillMode: Image.PreserveAspectFit
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.horizontalCenter
                    anchors.margins: parent.height * 0.01
                    smooth: true
                    source: lastPlayed
                }
            }

            Rectangle {
                id: turn
                color: "red"
                width: parent.width * 0.20
                height: parent.height * 0.005
                y: nameShadow.height - page.height * 0.005
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: nameShadow
                text: player
                x: playerName.x + page.height * 0.003
                y: playerName.y + page.height * 0.003
                font.pointSize: 32
                font.family: secondaryFont.name
            }

            Text {
                id: playerName
                text: player
                color: "white"
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 32
                font.family: secondaryFont.name
            }

            Row {

                anchors.top: turn.bottom
                anchors.left: parent.left
                anchors.margins: globalMargins
                z: 1000
                spacing: globalMargins
                width: page.width
                height: page.height * 0.10 + globalMargins
                visible: true
                Repeater {

                    model: statModel
                    delegate:
                    Rectangle {
                        width: page.width * 0.227
                        height: page.height * 0.10
                        z: 1000
                        color: baseColor
                        border.color: borderColor
                        border.width: globalMargins
                        radius: 20
                        Grid {
                            anchors.fill: parent
                            anchors.margins: globalMargins
                            columns: 2
                            rows: 2

                            Rectangle {
                                width: page.width * 0.227 / 2 - globalMargins
                                height: page.height * 0.10 / 2 - globalMargins
                                color: "#000000ff"
                                Image {
                                    anchors.centerIn: parent
                                    height: parent.height * 0.9
                                    fillMode: Image.PreserveAspectFit
                                    source: firstImg
                                }
                            }

                            Rectangle {
                                width: page.width * 0.227 / 2 - globalMargins
                                height: page.height * 0.10 / 2 - globalMargins
                                color: "#000000ff"
                                Text {
                                    text: firstStat
                                    anchors.centerIn: parent
                                }
                            }

                             Rectangle {
                                width: page.width * 0.227 / 2 - globalMargins
                                height: page.height * 0.10 / 2 - globalMargins
                                color: "#000000ff"
                                Image {
                                    anchors.centerIn: parent
                                    height: parent.height * 0.9
                                    fillMode: Image.PreserveAspectFit
                                    source: secondImg
                                }
                            }

                            Rectangle {
                                width: page.width * 0.227 / 2 - globalMargins
                                height: page.height * 0.10 / 2 - globalMargins
                                color: "#000000ff"
                                Text {
                                     text: secondStat
                                     anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    /******************MENU******************/

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
        id: menuButton
        width: page.width * 0.14
        height: width
        anchors.right: parent.right
        anchors.rightMargin: globalMargins
        anchors.bottom: parent.bottom
        anchors.bottomMargin: globalMargins

        color: "#d8a26b"
        border.color: "#cc8c38"
        border.width: globalMargins
        radius: 20

        MouseArea {
            anchors.fill: parent
            onClicked:
                game.toggleMenu()
        }

        Column {
            anchors.fill: parent
            anchors.margins: globalMargins*2
            spacing: 10
            Repeater {
            model: 3
            delegate:
                Rectangle {
                    width: parent.width
                    height: menuButton.height / 15
                    color: "#ffffff"
                }
            }
        }
    }

    Rectangle {
        id: menu

        width: 300
        height: 300
        color: "#d8a26b"
        border.color: "#cc8c38"
        border.width: globalMargins
        radius: 20
        anchors.centerIn: parent
        visible: true

        NumberAnimation on opacity {
            id: menuAnimation
            from: 0.00
            to: 1.00
            duration: 3000
        }

            Text {
                id: menuTitle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 15
                text: "Menu"
                font.pointSize: 32
                font.family: secondaryFont.name
            }

            Rectangle {
                id: newgameButton
                width: parent.width - 60
                height: parent.height/5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: menuTitle.bottom
                anchors.topMargin: globalMargins
                anchors.leftMargin: 30
                color: "#cc8c38"
                border.width: globalMargins
                border.color: "#cc8c38"
                radius: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked:
                        game.startGame()
                    onPressed:
                        newgameButton.color = "white"
                    onReleased:
                        newgameButton.color = "#cc8c38"
                }

                Text {
                    anchors.centerIn: parent
                    text: "New Game"
                    font.pointSize: 28
                    font.family: secondaryFont.name
                }
            }

    }


    /*********GAME DATA & FUNCTIONS**********/

    QtObject {
        id: blue
        property string name: "Blue"
        property string lastPlayed: "../content/cards/Dragon.png"

        property int builders: 2
        property int bricks: 5
        property int soldiers: 2
        property int weapons: 5
        property int sorcerers: 2
        property int crystals: 5
        property int castle: 30
        property int fence: 10
    }

    QtObject {
        id: red
        property string name: "Red"
        property string lastPlayed: "../content/cards/Banshee.png"

        property int builders: 2
        property int bricks: 5
        property int soldiers: 2
        property int weapons: 5
        property int sorcerers: 2
        property int crystals: 5
        property int castle: 30
        property int fence: 10
    }

    QtObject {
        id: game

        function attack(player, attack) {

            if ((player.fence - attack) > 0) {
                player.fence -= attack
                wall.y += attack * 5
            } else if ((player.fence - attack) <= 0) {
                var nextAttack = attack - player.fence
                player.fence = 0
                player.castle -= nextAttack
                wall.y = page.height - ground.height - grass.height + player.fence * 5
                castleimg.y += nextAttack * 5
                if (player.castle <= 0) {
                    endGame()
                }
            }

            else {
                player.fence -= attack
                wall.y += attack * 5
                castleimg.y += attack * 5
            }
        }

        function buildCastle(build) {
            player.castle += build

            if (player.castle >= 100) {
                endGame()
            }
            castleimg.y -= build * 5
        }

        function buildWall(build) {
            if (player.fence < 200) {
                player.fence += build
                wall.y -= build * 5
            }
        }

        function recruit() {

        }

        function school() {

        }

        function sorcerer() {

        }

        function startGame() {
            page.state = "gameOn"
            blue.builders = 2
            blue.bricks = 5
            blue.soldiers = 2
            blue.weapons = 5
            blue.sorcerers = 2
            blue.crystals = 5
            blue.castle = 30
            blue.fence = 10

            red.builders = 2
            red.bricks = 5
            red.soldiers = 2
            red.weapons = 5
            red.sorcerers = 2
            red.crystals = 5
            red.castle = 30
            red.fence = 10

            castleimg.y = page.height - ground.height - grass.height - blue.castle * 5 - 36
            wall.y = page.height - ground.height - grass.height - blue.fence * 5
            castleimg2.y = page.height - ground.height - grass.height - red.castle * 5 - 36
            wall2.y = page.height - ground.height - grass.height - red.fence * 5
        }

        function endGame() {
            page.state = "gameOver"
        }

        function turn() {
            blue.bricks += blue.builders
            blue.weapons += blue.soldiers
            blue.crystals += blue.sorcerers

            red.bricks += red.builders
            red.weapons += red.soldiers
            red.crystals += red.sorcerers
        }

        function toggleMenu() {
            if(menu.visible == true)
                menu.visible = false
            else
                menu.visible = true
        }
    }
}
