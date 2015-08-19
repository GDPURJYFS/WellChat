import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    id: page
    focus: true
    color: "#ebebeb"
    implicitWidth: 640
    implicitHeight: 400


    default property alias data: content.data

    signal entered()
    signal exited()
    property string title
    property PageStackWindow pageStackWindow: null

    readonly property int stackIndex: Stack.index
    property StackView stackView: null
    readonly property int status : Stack.status

    property Item background: null
    property TopBar topBar: null
    property BottomBar bottomBar: null

    Loader {
        id: panelLoader
        width: page.width
        height: page.height

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
            id: topBarParent
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            height: children[0] != null ? children[0].height: 0
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

//            // only one child allow in the Page control
//            onChildrenChanged: {
//                if(children[0] != null && children[1] != null ) {
//                    children[0].destory();
//                }
//            }
        }

        Item {
            id: bottomBarParent
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            height: children[0] != null ? children[0].height: 0
            onChildrenChanged: {
                if(children[0] != null && children[1] != null ) {
                    children[0].destory();
                }
            }
        }
    }

    function __PushPage(url, properties){
        var component = Qt.createComponent(url);

        properties = properties || { };

        try {
            if(component.status === Component.Ready) {
                // 防止点击过快，开启过多画面
                page.enabled = false;

                var loadPage = component.createObject(page.stackView, properties);

                loadPage.exited.connect(function() {
                    loadPage.exited.disconnect(arguments.callee);
                    page.enabled = true;
                    // 防止焦点丢失
                    page.focus = true;
                });

                loadPage.focus = true;
                loadPage.width = Qt.binding(function(){ return stackView.width });
                loadPage.height = Qt.binding(function(){ return stackView.height });
                loadPage.stackView = page.stackView;
                stackView.push({item: loadPage, destroyOnPop:true});
            } else {
                console.log("component errorString: ",component.errorString());
                page.enabled = true;
                page.focus = true;
            }
        } catch(e) {
            console.log("Error: ",e);
            console.log("component errorString: ",component.errorString());
            page.enabled = true;
            page.focus = true;
        }
    }


    Component.onCompleted: {
        entered();
    }

    Component.onDestruction: {
        exited();
    }

}
