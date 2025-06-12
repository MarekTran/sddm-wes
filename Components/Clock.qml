import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

ColumnLayout {
    id: clock
    
    property Item shadow
    property date currentTime: new Date()
    
    spacing: Kirigami.Units.smallSpacing
    
    // Font loaders for Jost fonts
    FontLoader {
        id: jostBlack
        source: Qt.resolvedUrl("../Fonts/Jost-900-Black.ttf")
    }
    
    FontLoader {
        id: jostMediumItalic
        source: Qt.resolvedUrl("../Fonts/Jost-500-MediumItalic.ttf")
    }
    
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: currentTime = new Date()
    }
    
    // Day of week in Jost Black, uppercase - large with yellow color
    Text {
        id: dayText
        text: Qt.formatDate(currentTime, "dddd").toUpperCase()
        color: "#F8F084"  // Wes Anderson yellow
        font.family: jostBlack.name
        font.pixelSize: Kirigami.Units.gridUnit * 7  
        font.weight: Font.Black
        Layout.alignment: Qt.AlignHCenter
    }
    
    // Time in AM/PM format with Jost Medium Italic - white color
    Text {
        id: timeText
        text: Qt.formatTime(currentTime, "hh:mm AP")
        color: "white"  // Keeping white as requested
        font.family: jostMediumItalic.name
        font.pixelSize: Kirigami.Units.gridUnit * 4
        font.italic: true
        font.weight: Font.Medium
        Layout.alignment: Qt.AlignHCenter
    }
} 