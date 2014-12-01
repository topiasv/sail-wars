.import QtQuick 2.0 as QQ
//.import "../pages/FirstPage.qml" as QML

var gameState = {
	gameRunning:false,
	gameOver:true
};

var build = {
    builders:2,
    bricks:5
};

var attack = {
    soldiers:2,
    weapons:5
};

var magic = {
    wizards:2,
    crystals:5
};

var health = {
    castle:30,
    fence:10
};

function startGame() {
    console.log("Game started");
	gameState.gameRunning = true;
	gameState.gameOver = false;
}
