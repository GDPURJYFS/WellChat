import Resource 1.0 as R
import BussinessPage 1.0 as BR

import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

import "../Component"
import "./Contacts"

import Sparrow 1.0

Page {
    id: contactsView

    title: qsTr("Contacts")
    property int headPrtraitSize: 50

    property ListView mainListView: null

    ContactsListView {
        mainListView: contactsView.mainListView
        width: contactsView.width
        height: contactsView.height

        section.property: "name"
        section.criteria: ViewSection.FirstCharacter
        section.delegate: Rectangle {
            width: contactsView.width
            height: childrenRect.height
            color: "transparent"

            SampleLabel {
                text: section
            }
        }
        model: ListModel {
            id: personModel

            Component.onCompleted: {
                personModel
                var d = ["☆","a1","a1","a1", "a1","a1","a1","a1","a1","a1","a1","a1",
                         "b2","b2","b2","b2","b2","b2","b2","b2","b2","b2","b2","b2",
                         "b2","b2","b2","b2","b2","b2","b2","b2","b2","b2","b2","b2",
                         "b2","b2","b2","b2","b2","b2","b2","b2","b2","b2","b2","b2",
                         "b2","c3","c3","c3","c3","c3","c3","c3","c3","c3","c3","d",
                         "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
                         "q", "r", "s", "t", "u", "v", "w","x24", "x24","x24","x24","x24",
                         "x24","x24","x24","x24","x24","x24","x24","x24","x24","x24","x24",
                         "x24","x24","x24","y", "z"];
                for(var i=0;i<d.length; i++) {
                    personModel.append({"name": d[i]});
                }
            }

        }

        delegate: ColumnLayout {
            width: contactsView.width
            height: l.height
            IconLabel {
                id: l
                spacing: 10
                Layout.fillWidth: true;
                iconSource: R.R.testPic
                labelText: qsTr("哔哩哔哩")
                onPressAndHold: {
                    menu.chatItemIndex = index;
                    menu.popup();
                }
                Separator {
                    color: "#999"; orientation: Qt.Horizontal ;
                    length: parent.width * 0.8
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                onClicked: {
                    console.log("go to the person profile");
                    __PushPage(BR.R.profilePage);
                }
            }
        }

        Menu {
            id: menu
            property int chatItemIndex: 0
            MenuItem {
                text: qsTr("Set Remarks and Tags")
                onTriggered: {

                }
            }
        }
    }
}

