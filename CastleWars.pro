# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = CastleWars

CONFIG += sailfishapp

SOURCES += src/CastleWars.cpp

OTHER_FILES += qml/CastleWars.qml \
    qml/cover/CoverPage.qml \
    rpm/CastleWars.changes.in \
    rpm/CastleWars.spec \
    rpm/CastleWars.yaml \
    translations/*.ts \
    CastleWars.desktop \
    content/gfx/background.svg \
    qml/content/gfx/background.svg \
    qml/content/gfx/background.png \
    qml/content/gfx/cwtitle.png \
    qml/content/logic.js \
    qml/content/gfx/castle-red.png \
    qml/content/gfx/castle-blue.png \
    qml/pages/MainPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/CastleWars-de.ts

