import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as QQC2
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3

Rectangle {
    id: loginForm
    
    color: "transparent"
    
    // Font loaders for Jost fonts
    FontLoader {
        id: jostBlack
        source: Qt.resolvedUrl("Fonts/Jost-900-Black.ttf")
    }
    
    FontLoader {
        id: jostMediumItalic
        source: Qt.resolvedUrl("Fonts/Jost-500-MediumItalic.ttf")
    }
    
    ColumnLayout {
        anchors.centerIn: parent
        spacing: Kirigami.Units.largeSpacing * 2
        width: 350
        
        // Clock at the top
        Clock {
            id: clock
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: Kirigami.Units.largeSpacing * 2
        }
        
        // Semi-transparent background for form fields
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: formLayout.implicitHeight + Kirigami.Units.largeSpacing * 2
            color: Qt.rgba(0, 0, 0, 0.3)
            radius: 10
            
            ColumnLayout {
                id: formLayout
                anchors.centerIn: parent
                width: parent.width - Kirigami.Units.largeSpacing * 2
                spacing: Kirigami.Units.largeSpacing
                
                // Username field
                PlasmaComponents3.TextField {
                    id: usernameField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    placeholderText: "USERNAME"
                    font.family: jostMediumItalic.name
                    font.pixelSize: 16
                    horizontalAlignment: TextInput.AlignHCenter
                    
                    background: Rectangle {
                        color: Qt.rgba(255, 255, 255, 0.9)
                        radius: 5
                        border.color: "#F8F084"
                        border.width: 2
                    }
                    
                    onAccepted: passwordField.forceActiveFocus()
                }
                
                // Password field
                PlasmaComponents3.TextField {
                    id: passwordField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    placeholderText: "PASSWORD"
                    echoMode: TextInput.Password
                    font.family: jostMediumItalic.name
                    font.pixelSize: 16
                    horizontalAlignment: TextInput.AlignHCenter
                    
                    background: Rectangle {
                        color: Qt.rgba(255, 255, 255, 0.9)
                        radius: 5
                        border.color: "#F8F084"
                        border.width: 2
                    }
                    
                    onAccepted: loginButton.clicked()
                }
                
                // Login button
                PlasmaComponents3.Button {
                    id: loginButton
                    Layout.fillWidth: true
                    Layout.preferredHeight: 50
                    text: "LOGIN"
                    font.family: jostBlack.name
                    font.pixelSize: 18
                    
                    background: Rectangle {
                        color: loginButton.hovered ? "#F8F084" : Qt.rgba(248, 240, 132, 0.8)
                        radius: 5
                        
                        Behavior on color {
                            ColorAnimation { duration: 200 }
                        }
                    }
                    
                    contentItem: Text {
                        text: loginButton.text
                        font: loginButton.font
                        color: loginButton.hovered ? "black" : "#333333"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    
                    onClicked: {
                        sddm.login(usernameField.text, passwordField.text, sessionSelect.currentIndex)
                    }
                }
            }
        }
        
        // Session and system controls
        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: Kirigami.Units.largeSpacing * 2
            
            // Session selector
            PlasmaComponents3.ComboBox {
                id: sessionSelect
                model: sessionModel
                textRole: "name"
                currentIndex: sessionModel.lastIndex
                
                background: Rectangle {
                    color: Qt.rgba(255, 255, 255, 0.8)
                    radius: 5
                    border.color: "#F8F084"
                    border.width: 1
                }
            }
            
            // System buttons
            RowLayout {
                spacing: Kirigami.Units.smallSpacing
                
                PlasmaComponents3.ToolButton {
                    icon.name: "system-reboot"
                    onClicked: sddm.reboot()
                    enabled: sddm.canReboot
                    
                    PlasmaComponents3.ToolTip {
                        text: "Restart"
                    }
                }
                
                PlasmaComponents3.ToolButton {
                    icon.name: "system-shutdown"
                    onClicked: sddm.powerOff()
                    enabled: sddm.canPowerOff
                    
                    PlasmaComponents3.ToolTip {
                        text: "Shut Down"
                    }
                }
            }
        }
    }
    
    // Handle login failure
    Connections {
        target: sddm
        function onLoginFailed() {
            passwordField.text = ""
            passwordField.forceActiveFocus()
        }
    }
    
    Component.onCompleted: {
        // Focus username field on load
        usernameField.forceActiveFocus()
    }
} 