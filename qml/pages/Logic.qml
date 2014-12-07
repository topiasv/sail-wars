import QtQuick 2.0

QtObject {
    id: blue
    property int builders
    property int bricks
    property int soldiers
    property int weapons
    property int sorcerers
    property int crystals
    property int castle
    property int fence
}

QtObject {
    id: red
    property int builders
    property int bricks
    property int soldiers
    property int weapons
    property int sorcerers
    property int crystals
    property int castle
    property int fence
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
                action.endGame()
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
            action.endGame()
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
