import QtQuick 2.15

SequentialAnimation {
    property Item target
    
    NumberAnimation {
        target: parent.target
        property: "x"
        from: 0
        to: 10
        duration: 50
    }
    NumberAnimation {
        target: parent.target
        property: "x"
        from: 10
        to: -10
        duration: 100
    }
    NumberAnimation {
        target: parent.target
        property: "x"
        from: -10
        to: 0
        duration: 50
    }
} 