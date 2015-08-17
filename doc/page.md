# Page 实现简述

- default data : list<`Item`>
        
    建议在 `Page` 内部使用 `ScrollView`，`ListView`，`GridView`，`ColumnLayout`，`RowLayout` 等视图控件或者布局控件。
    
    ```qml
    Page {
        ScrollView {
            anchors.fill: parent
            // other Item
        }
    }
    ```

- background : `Item`
    
    用来设置 `Page` 的背景。
    
    ```qml
    Page {
        background: Image { source: "background" }
        ......
    }
    ```

- topBar : [`TopBar`](top-bar.md)
    
    `Page` 中顶部的 `Bar`。

    ```qml
    Page {
        topBar: TopBar { 
            RowLayout {
                anchors.fill
            }
        }
        ......
    }
    ```
    > note: 有一些问题。[看这里](top-bar.md)

- bottomBar : [`BottomBar`](bottom-bar.md)
    
    `Page` 顶部的 `Bar`

    ```qml
    Page {
        bottomBar: BottomBar { 
            RowLayout {
                anchors.fill
            }
        }
        ......
    }
    ```
    > note: 高度问题，会根据内部孩子的总高度决定。

---

下面是源码解析：

```qml
import QtQuick 2.5
import QtQuick.Controls 1.4

Rectangle {
    id: page
    ......

    default property alias data: content.data

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
```

到这里，内部声明了一个 `Loader` 用来加载一些控件，例如 `TopBar` 和 `BottomBar`。至于为什么叫做 `TopBar` 和 `BottomBar`，主要是为了区别 `ToolBar` 和 `StatusBar`，因为某些平台上 `ToolBar` 可能和 `StatusBar` 一样，在底部，或者在顶部。用方位来命名 `Bar`，在未来还可以进行拓展，例如增加 `RightBar` 和 `LeftBar`。

```qml
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
```

背景应该在内容层的下面，所以先定义。并且在 `Page::background` 重新指向一个新的 `Item` 时，会删除之前的背景，确保背景只有一个 `Item`。如果不删除的话，会有多个背景重叠。下面的 `TopBar` 和 `BottomBar` 一样，可以确保只有一个孩子控件。

```qml
        Item {
            id: topBarParent
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            height: children[0] != null ? children[0].height: 0
        }
```

`content.data` 被指定到 `Page::data` 这个默认属性。

```qml
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
```

和 `TopBar` 类似。

```qml
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
}
```

~~这个 `Page` 代码借鉴自 `ApplicationWindow`，代码不懂的，我也不想解释，就酱紫。~~
