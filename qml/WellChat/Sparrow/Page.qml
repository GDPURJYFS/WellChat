import QtQuick 2.4
import QtQuick.Controls 1.2
import Sparrow 1.0

Rectangle {
    id: page

    width: 360
    height: 640

    focus: true

    color: "#ebebeb"

    default property alias data: content.data

    signal entered()
    signal exited()

    property string title
    property PageStackWindow pageStackWindow: null

    property StackView stackView: Stack.view

    property Item background: null
    property TopBar topBar: null
    property BottomBar bottomBar: null

    property bool showTopBar: true
    property bool showBottomBar: true

    property alias topBarArea: topBarParent
    property alias bottomBarArea: bottomBarParent
    property alias backgroundArea: backgroundParent

    readonly property int applicationState: Qt.application.state


    /*
    enabled: try {
                 return Stack.view != null ?
                             (Stack.status != Stack.Inactive
                              ? true : false)
                           : true;

             } catch(e) {
                 console.log(e);
                 console.trace();
                 return true;
             }
    */
    Loader {
        anchors.fill: parent

        Binding { target: topBar; property: "parent"; value: topBarParent }
        Binding { target: bottomBar; property: "parent"; value: bottomBarParent }
        Binding { target: background; property: "parent"; value:  backgroundParent}

        Item {
            id: backgroundParent
            anchors.fill: parent
            onChildrenChanged: {

                // @disable-check M126
                if(children[0] != null && children[1] != null ) {
                    children[0].destory();

                    //@disable-check M126
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

            // because content.data is Page data(default property)
            property alias color: page.color
            property alias title: page.title
            property alias pageStackWindow: page.pageStackWindow

            property alias stackView: page.stackView

            property alias background: page.background
            property alias topBar: page.topBar
            property alias bottomBar: page.bottomBar

            property alias showTopBar: page.showTopBar
            property alias showBottomBar: page.showBottomBar

            property alias topBarArea: page.topBarArea
            property alias bottomBarArea: page.bottomBarArea
            property alias backgroundArea: page.backgroundArea
            readonly property alias applicationState: page.applicationState

        }

        Item {
            id: topBarParent
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.left: parent.left
            // @disable-check M126
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
            // @disable-check M126
            height: children[0] != null ? children[0].height: 0

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

    // not support the network qml resources
    // push(D, replace) => [A, B, D] - "replace" transition between C and D
    function __PushPage(url, properties, replace){
        var component = Qt.createComponent(url);

        properties = properties || { };
        replace = replace || false;

        try {
            if(component.status === Component.Ready) {

                // 防止点击过快，开启过多画面
                page.enabled = false;

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
                //! push(D, replace) => [A, B, D] - "replace" transition between C and D
                stackView.push({item: loadPage
                                   , destroyOnPop:true
                                   // 不能用。 界面会僵死
                                   // , replace: replace
                               });
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

    Component.onCompleted: {
        entered();
    }

    Component.onDestruction: exited();
}
