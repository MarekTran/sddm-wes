import QtQuick 2.15

Loader {
    property Item screenRoot
    property Item mainStack
    property Item mainBlock
    property Item passwordField
    property bool keyboardActive: false
    
    function showHide() {
        keyboardActive = !keyboardActive
    }
} 