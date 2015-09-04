import QtQuick 2.4
import QtQuick.Controls 1.2
import Sparrow 1.0

Rectangle {
    id: page
    focus: true
    color: "#ebebeb"
    //    implicitWidth: 640
    //    implicitHeight: 400

    default property alias data: content.data

    signal entered()
    signal exited()

    property string title
    property PageStackWindow pageStackWindow: null

    readonly property int stackIndex: Stack.index
    readonly property int status : Stack.status
    property StackView stackView: null

    property Item background: null
    property TopBar topBar: null
    property BottomBar bottomBar: null

    property bool showTopBar: true
    property bool showBottomBar: true

    Loader {
        anchors.fill: parent

        Binding { target: topBar; property: "parent"; value: topBarParent }
        Binding { target: bottomBar; property: "parent"; value: bottomBarParent }
        Binding { target: background; property: "parent"; value:  backgroundParent}

        Item {
            id: backgroundParent
            anchors.fill: parent
            onChildrenChanged: {
                if(children[0] != null && children[1] != null ) {
                    children[0].destory();
                } else if(children[0] != null) {
                    children[0].anchors.fill = backgroundParent;
                }
            }            
        }

        Item {
            id: content
            focus: page.focus
            width: page.width
            height: page.height
            clip: true

            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: topBarParent.bottom
            anchors.bottom: bottomBarParent.top
        }

        Item {
            id: topBarParent
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            height: children[0] != null ? children[0].height: 0
            clip: true

            state: "ShowTopBar"

            states: [
                State {
                    when: !showTopBar
                    name: "HideTopBar"
                    changes: [
                        PropertyChanges {
                            target: topBarParent
                            anchors.topMargin: -topBarParent.height
                        }
                    ]
                },
                State {
                    when: showTopBar
                    name: "ShowTopBar"
                    changes: [
                        PropertyChanges {
                            target: topBarParent
                            anchors.topMargin: 0
                        }
                    ]
                }
            ]

            transitions: [
                Transition {
                    from: "ShowTopBar"
                    to: "HideTopBar"

                    NumberAnimation {
                        property: "anchors.topMargin"
                        duration: 500
                    }

                },
                Transition {
                    from: "HideTopBar"
                    to: "ShowTopBar"

                    NumberAnimation {
                        property: "anchors.topMargin"
                        duration: 500
                    }
                }
            ]
        }

        Item {
            id: bottomBarParent
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            height: children[0] != null ? children[0].height: 0
//            onChildrenChanged: {
//                if(children[0] != null && children[1] != null ) {
//                    children[0].destory();
//                }
//            }

            state: "ShowBottomBar"

            states: [
                State {
                    when: !showBottomBar
                    name: "HideBottomBar"
                    changes: [
                        PropertyChanges {
                            target: bottomBarParent
                            anchors.bottomMargin: -bottomBarParent.height
                        }
                    ]
                },
                State {
                    when: showBottomBar
                    name: "ShowBottomBar"
                    changes: [
                        PropertyChanges {
                            target: bottomBarParent
                            anchors.bottomMargin: 0
                        }
                    ]
                }
            ]

            transitions: [
                Transition {
                    from: "ShowBottomBar"
                    to: "HideBottomBar"

                    NumberAnimation {
                        property: "anchors.bottomMargin"
                        duration: 500
                    }

                },
                Transition {
                    from: "HideBottomBar"
                    to: "ShowBottomBar"

                    NumberAnimation {
                        property: "anchors.bottomMargin"
                        duration: 500
                    }
                }
            ]

        }
    }

    function __PushPage(url, properties){
        var component = Qt.createComponent(url);

        properties = properties || { };

        try {
            if(component.status === Component.Ready) {
                // 防止点击过快，开启过多画面
                if(ApplicationSettings.defaultPageEnablePush) {
                    page.enabled = false;
                }

                properties.focus = true;
                properties.width = Qt.binding(function(){ return stackView.width });
                properties.height = Qt.binding(function(){ return stackView.height });
                properties.stackView = page.stackView;

                var loadPage = component.createObject(page.stackView, properties);

                loadPage.exited.connect(function() {
                    loadPage.exited.disconnect(arguments.callee);
                    page.enabled = true;
                    // 防止焦点丢失
                    page.focus = true;
                });

                //                loadPage.focus = true;
                //                loadPage.width = Qt.binding(function(){ return stackView.width });
                //                loadPage.height = Qt.binding(function(){ return stackView.height });
                //                loadPage.stackView = page.stackView;
                stackView.push({item: loadPage, destroyOnPop:true});
                return loadPage;
            } else {
                console.log("component errorString: ",component.errorString());
                page.enabled = true;
                page.focus = true;
                return null;
            }
        } catch(e) {
            console.log("Error: ",e);
            console.log("component errorString: ",component.errorString());
            page.enabled = true;
            page.focus = true;
            return null;
        }
    }
    Component.onCompleted: entered();

    Component.onDestruction: exited();
}
