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
            PropertyChanges { target: gameView; visible: true }
            PropertyChanges { target: menu; visible: false }
            PropertyChanges { target: title; visible: false }
            StateChangeScript { script: console.log("state = gameOn") }
        },

        State {
            name: "gameOver"
            PropertyChanges { target: gameView; visible: false }
            PropertyChanges { target: menu; visible: true }
            PropertyChanges { target: title; visible: true }
            StateChangeScript { script: console.log("state = gameOver") }
        }

    ]

    /**************BACKGROUNDS***************/

    Rectangle {
        id: sky
        anchors.bottom: grass.top
        anchors.top: page.top
        anchors.left: page.left
        anchors.right: page.right
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
        color: "#006600"
        z: 1000
    }

    /*************PLAYER GRAPHICS************/

    /*****************MODELS*****************/

    ListModel {
        id: castleModel
        dynamicRoles: true
        Component.onCompleted: {
            castleModel.append({castleSource: "../content/gfx/castle-blue.png",
                                castleY: blue.castle,
                                wallY: blue.fence,
                                wallX: page.width * 0.875,
                                turnStatus: true,
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
                                castleY: red.castle,
                                wallY: red.fence,
                                wallX: page.width * 0.125,
                                turnStatus: false,
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
                //testFunction: game.buildWall(blue, 5),
                firstImg: "../content/gfx/brick.png",
                firstStat: blue.builders,
                secondImg: "../content/gfx/brick.png",
                secondStat: blue.bricks,
            })
            blueStatModel.append ({
                baseColor: "#66ff57",
                borderColor: "#006600",
                //testFunction: game.attack(red, 5),
                firstImg: "../content/gfx/weapon.png",
                firstStat: blue.soldiers,
                secondImg: "../content/gfx/weapon.png",
                secondStat: blue.weapons,
            })
            blueStatModel.append ({
                baseColor: "#02b3fd",
                borderColor: "#003399",
                //testFunction: game.buildCastle(blue, 5),
                firstImg: "../content/gfx/crystal.png",
                firstStat: blue.sorcerers,
                secondImg: "../content/gfx/crystal.png",
                secondStat: blue.crystals,
            })
            blueStatModel.append ({
                baseColor: "#666666",
                borderColor: "#000000",
                //testFunction: game.build(blue, 20),
                firstImg: "../content/gfx/brick.png",
                firstStat: blue.castle,
                secondImg: "../content/gfx/brick.png",
                secondStat: blue.fence,
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
                secondStat: red.bricks,
            })
            redStatModel.append ({
                baseColor: "#66ff57",
                borderColor: "#006600",
                firstImg: "../content/gfx/weapon.png",
                firstStat: red.soldiers,
                secondImg: "../content/gfx/weapon.png",
                secondStat: red.weapons,
            })
            redStatModel.append ({
                baseColor: "#02b3fd",
                borderColor: "#003399",
                firstImg: "../content/gfx/crystal.png",
                firstStat: red.sorcerers,
                secondImg: "../content/gfx/crystal.png",
                secondStat: red.crystals,
            })
            redStatModel.append ({
                baseColor: "#666666",
                borderColor: "#000000",
                firstImg: "../content/gfx/brick.png",
                firstStat: red.castle,
                secondImg: "../content/gfx/brick.png",
                secondStat: red.fence,
            })
        }
    }

    /******************VIEWS*****************/

    ListView {
        id: gameView
        width: parent.width
        height: parent.height
        boundsBehavior: Flickable.StopAtBounds
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        visible: false
        model: castleModel
        delegate:

        Rectangle {
            height: page.height
            width: page.width
            color: "#000000ff"

            Image {
                id: castleimg
                source: castleSource
                anchors.horizontalCenter: parent.horizontalCenter
                height: page.height * 0.725
                fillMode: Image.PreserveAspectFit
                y: page.height - ground.height - grass.height - castleY * 5 - 36
                z: 100
            }

            Image {
                id: wall
                source: "../content/gfx/wall.png"
                x: wallX
                y: page.height - ground.height - grass.height - wallY * 5
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
                    MouseArea {
                        anchors.fill: parent
                        onClicked:{
                            if (cardMenu.visible == false)
                                cardMenu.visible = true
                            else
                                cardMenu.visible = false
                        }
                    }
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
                visible: turnStatus
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
                        MouseArea {
                            anchors.fill: parent
                            onClicked:
                                console.log("Hi!")
                        }
                    }
                }
            }
        }
    }

    /***************CARD MENU****************/

    ListModel {
        id: cardsModel
        dynamicRoles: true
        Component.onCompleted: {
            //Build
            cardsModel.append({card: "../content/cards/Build/Base.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Wall.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Defence.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Reserve.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Tower.png"

                              })
            cardsModel.append({card: "../content/cards/Build/School.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Wain.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Fence.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Fort.png"

                              })
            cardsModel.append({card: "../content/cards/Build/Babylon.png"

                              })
            //Weapons

            cardsModel.append({card: "../content/cards/Weapons/Archer.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Knight.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Rider.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Platoon.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Recruit.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Attack.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Saboteur.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Thief.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Swat.png"

                              })
            cardsModel.append({card: "../content/cards/Weapons/Banshee.png"

                              })

            //Magic

            cardsModel.append({card: "../content/cards/Magic/Conjurebricks.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Conjurecrystals.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Conjureweapons.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Crushbricks.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Crushcrystals.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Crushweapons.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Sorcerer.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Dragon.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Pixies.png"

                              })
            cardsModel.append({card: "../content/cards/Magic/Curse.png"

                              })
        }
    }

    Rectangle {
        id: cardMenu
        visible: false
        anchors.fill: sky
        anchors.margins: globalMargins
        color: "#d8a26b"
        border.color: "#cc8c38"
        border.width: globalMargins
        radius: 20
        z: 10000

        GridView {
            id: cardsView
            anchors.fill: cardMenu
            anchors.margins: globalMargins
            clip: true

            cellWidth: width / 5
            cellHeight: height / 4

            model: cardsModel
            delegate:
            Item {
                width: cardsView.cellWidth
                height: cardsView.cellHeight
                Image {
                    id: cardItem
                    height: parent.height - globalMargins * 2
                    anchors.centerIn: parent
                    anchors.margins: globalMargins
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    source: card

                    MouseArea {

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
        z: 100000

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

    ListModel {
        id: menuButtonsModel
        dynamicRoles: true
        Component.onCompleted: {
            menuButtonsModel.append({label: "New Game",
                                     action: game.startGame()
            })
            menuButtonsModel.append({label: "Cards",
                                        action: function showCards() {
                                            if (cardMenu.visible == false)
                                                cardMenu.visible = true
                                            else
                                                cardMenu.visible = false
                                        }
            })
        }

    }

    Rectangle {
        id: menu

        height: page.height * 0.32
        width: height
        color: "#d8a26b"
        border.color: "#cc8c38"
        border.width: globalMargins
        radius: 20
        anchors.centerIn: parent
        visible: true
        z: 100000

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

        Column {
            id: buttonsContainer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: menuTitle.bottom
            anchors.bottom: menu.bottom
            anchors.margins: globalMargins
            spacing: globalMargins
            Rectangle {
                width: menu.width - 60
                height: menu.height/5
                color: "#cc8c38"
                border.width: globalMargins
                border.color: "#cc8c38"
                radius: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked:
                        game.startGame()
                    onPressed:
                        parent.color = "white"
                    onReleased:
                        parent.color = "#cc8c38"
                }

                Text {
                    anchors.centerIn: parent
                    text: "New Game"
                    font.pointSize: 28
                    font.family: secondaryFont.name
                }
            }

            Rectangle {
                width: menu.width - 60
                height: menu.height/5
                color: "#cc8c38"
                border.width: globalMargins
                border.color: "#cc8c38"
                radius: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        game.attack(blue,5)
                    }
                    onPressed:
                        parent.color = "white"
                    onReleased:
                        parent.color = "#cc8c38"
                }

                Text {
                    anchors.centerIn: parent
                    text: "Attack"
                    font.pointSize: 28
                    font.family: secondaryFont.name
                }
            }

            Rectangle {
                width: menu.width - 60
                height: menu.height/5
                color: "#cc8c38"
                border.width: globalMargins
                border.color: "#cc8c38"
                radius: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        game.changeTurn()
                    }
                    onPressed:
                        parent.color = "white"
                    onReleased:
                        parent.color = "#cc8c38"
                }

                Text {
                    anchors.centerIn: parent
                    text: "Turn"
                    font.pointSize: 28
                    font.family: secondaryFont.name
                }
            }
        }
    }/*
            Rectangle {
                id: newgameButton
                width: parent.width - 60
                height: parent.height/5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: newgameButton.bottom
                anchors.topMargin: globalMargins
                anchors.leftMargin: 30
                color: "#cc8c38"
                border.width: globalMargins
                border.color: "#cc8c38"
                radius: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked:
                        if (cardMenu.visible == false)
                            cardMenu.visible = true
                        else
                            cardMenu.visible = false
                    onPressed:
                        cardButton.color = "white"
                    onReleased:
                        cardButton.color = "#cc8c38"
                }

                Text {
                    anchors.centerIn: parent
                    text: "Cards"
                    font.pointSize: 28
                    font.family: secondaryFont.name
                }
            }

            Rectangle {
                id: cardButton
                width: parent.width - 60
                height: parent.height/5
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: newgameButton.bottom
                anchors.topMargin: globalMargins
                anchors.leftMargin: 30
                color: "#cc8c38"
                border.width: globalMargins
                border.color: "#cc8c38"
                radius: 20

                MouseArea {
                    anchors.fill: parent
                    onClicked:
                        if (cardMenu.visible == false)
                            cardMenu.visible = true
                        else
                            cardMenu.visible = false
                    onPressed:
                        cardButton.color = "white"
                    onReleased:
                        cardButton.color = "#cc8c38"
                }

                Text {
                    anchors.centerIn: parent
                    text: "Cards"
                    font.pointSize: 28
                    font.family: secondaryFont.name

                }
            }
        }
*/
/*        Column {
            id: buttonsContainer
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: menuTitle.bottom
            anchors.bottom: menu.bottom
            anchors.margins: globalMargins
            spacing: globalMargins
            Repeater {
                model: menuButtonsModel
                delegate:
                Rectangle {
                    width: menu.width - 60
                    height: menu.height/5
                    color: "#cc8c38"
                    border.width: globalMargins
                    border.color: "#cc8c38"
                    radius: 20

                    MouseArea {
                        anchors.fill: parent
                        onClicked:
                            action
                        onPressed:
                            parent.color = "white"
                        onReleased:
                            parent.color = "#cc8c38"
                    }

                    Text {
                        anchors.centerIn: parent
                        text: label
                        font.pointSize: 28
                        font.family: secondaryFont.name
                    }
                }
            }
        }*/


    /*********GAME DATA & FUNCTIONS**********/

    QtObject {
        id: blue
        property string name: "Blue"
        property string lastPlayed: "../content/cards/Magic/Dragon.png"

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
        property string lastPlayed: "../content/cards/Weapons/Banshee.png"

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

        property string turn: "blue"

        function attack(player, attack) {

            if ((player.fence - attack) > 0) {
                player.fence -= attack
                if (player === "red") {
                    redStatModel.setProperty(3,"secondStat",player.fence)
                    castleModel.setProperty(1,"wallY",player.fence)
                }
                else {
                    blueStatModel.setProperty(3,"secondStat",player.fence)
                    castleModel.setProperty(0,"wallY",player.fence)
                }
            } else if ((player.fence - attack) <= 0) {
                var nextAttack = attack - player.fence
                player.fence = 0
                player.castle -= nextAttack
                if (player === "red") {
                    redStatModel.setProperty(3,"firstStat",player.castle)
                    redStatModel.setProperty(3,"secondStat",player.fence)
                    castleModel.setProperty(1,"castleY",player.castle)
                    castleModel.setProperty(1,"wallY",player.fence)
                }
                else {
                    blueStatModel.setProperty(3,"firstStat",player.castle)
                    blueStatModel.setProperty(3,"secondStat",player.fence)
                    castleModel.setProperty(0,"castleY",player.castle)
                    castleModel.setProperty(0,"wallY",player.fence)
                }
                if (player.castle <= 0) {
                    endGame()
                }
            } else {
                player.castle -= attack
                if (player === "red") {
                    redStatModel.setProperty(3,"firstStat",player.castle)
                    castleModel.setProperty(1,"castleY",player.castle)
                }
                else {
                    blueStatModel.setProperty(3,"firstStat",player.castle)
                    castleModel.setProperty(0,"castleY",player.castle)
                }
            }
        }

        function buildCastle(player, build) {
            player.castle += build
            if (player === "red") {
                redStatModel.setProperty(3,"firstStat",player.castle)
                castleModel.setProperty(1,"castleY",player.castle)
            }
            else {
                blueStatModel.setProperty(3,"firstStat",player.castle)
                castleModel.setProperty(0,"castleY",player.castle)
            }
            if (player.castle >= 100) {
                endGame()
            }
        }

        function buildWall(player, build) {
            if (player.fence < 200) {
                player.fence += build
                if (player === "red") {
                    redStatModel.setProperty(3,"secondStat",player.fence)
                    castleModel.setProperty(1,"wallY",player.fence)
                }
                else {
                    blueStatModel.setProperty(3,"secondStat",player.fence)
                    castleModel.setProperty(0,"wallY",player.fence)
                }
            }
        }

        function school(player) {
            player.builders += 1
            console.log(player.builders)
            if (player === "red")
                redStatModel.setProperty(0,"firstStat",player.soldiers)
            else
                blueStatModel.setProperty(0,"firstStat",player.soldiers)
        }

        function recruit(player) {
            player.soldiers += 1
            console.log(player.soldiers)
            if (player === "red")
                redStatModel.setProperty(1,"firstStat",player.soldiers)
            else
                blueStatModel.setProperty(1,"firstStat",player.soldiers)
        }

        function sorcerer(player) {
            player.sorcerers += 1
            console.log(player.sorcerers)
            if (player === "red")
                redStatModel.setProperty(2,"firstStat",player.soldiers)
            else
                blueStatModel.setProperty(2,"firstStat",player.soldiers)
        }

        function startGame() {
            resetStats(blue)
            resetStats(red)

            castleModel.setProperty(0,"castleY",blue.castle)
            castleModel.setProperty(0,"wallY",blue.fence)
            blueStatModel.setProperty(3,"firstStat",blue.castle)
            blueStatModel.setProperty(3,"secondStat",blue.fence)

            castleModel.setProperty(1,"castleY",red.castle)
            castleModel.setProperty(1,"wallY",red.fence)
            redStatModel.setProperty(3,"firstStat",red.castle)
            redStatModel.setProperty(3,"secondStat",red.fence)
            page.state = "gameOn"
        }

        function endGame() {
            page.state = "gameOver"
        }

        function changeTurn() {
            if (turn === "blue") {
                turn = "red"
                castleModel.setProperty(0,"turnStatus",false)
                castleModel.setProperty(1,"turnStatus",true)
                gameView.positionViewAtIndex(1, ListView.SnapPosition)
            } else {
                turn = "blue"
                castleModel.setProperty(1,"turnStatus",false)
                castleModel.setProperty(0,"turnStatus",true)
                gameView.positionViewAtIndex(0, ListView.SnapPosition)
            }

            blue.bricks += blue.builders
            blue.weapons += blue.soldiers
            blue.crystals += blue.sorcerers

            blueStatModel.setProperty(0,"secondStat",blue.bricks)
            blueStatModel.setProperty(1,"secondStat",blue.weapons)
            blueStatModel.setProperty(2,"secondStat",blue.crystals)

            red.bricks += red.builders
            red.weapons += red.soldiers
            red.crystals += red.sorcerers

            redStatModel.setProperty(0,"secondStat",red.bricks)
            redStatModel.setProperty(1,"secondStat",red.weapons)
            redStatModel.setProperty(2,"secondStat",red.crystals)
        }

        function toggleMenu() {
            if(menu.visible == true)
                menu.visible = false
            else
                menu.visible = true
        }

        function resetStats(player) {
            player.builders = 2
            player.bricks = 5
            player.soldiers = 2
            player.weapons = 5
            player.sorcerers = 2
            player.crystals = 5
            player.castle = 30
            player.fence = 10
        }
    }
}
