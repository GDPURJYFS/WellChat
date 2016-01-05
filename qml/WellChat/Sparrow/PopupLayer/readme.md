# PopupLayer

使用 QML 实现的弹出层。

使用注意事项。

1. `PopupLayer` 内部有个 `popupItem`，是作为这个控件内部孩子的默认父指针。

2. `PopupLayer` 默认覆盖他的 `parent`（可以显示指定），但是在内部没有直接指定其 `z` 序。在使用的时候，需要注意其实例化的位置。（QML 文档实例化可视对象时，从上往下实例化，位于最下面的可视化对象会在顶层显示，可以通过设定 `z` 序来处理）。

3. `PopupLayer` 的 `delegate` 属性是仿制 `StackViewDelegate` 的机制。提供了一个 `PopupLayerDelegate`。

4. `PopupLayerDelegate` 声明如下：

    ```
    //~ PopupLayerDelegate
    import QtQuick 2.0

    QtObject {
        id: popupLayerDelegate
        property PopupLayerTransition showTransition: null
        property PopupLayerTransition hideTransition: null
        property Item popupItem: null
        property Item maskItem: null
        property list<QtObject> showChanges
        property list<QtObject> hideChanges
    }
    ```

    声明了需要捕获的 `popupItem` 和 `maskItem`。

    声明了两个改变列表。

    声明了两个 `PopupLayerTransition` 接口，在这个 `PopupLayerTransition` 接口中实现必要的动画。

    `PopupLayerTransition` 声明如下

    ```
    import QtQuick 2.0

    QtObject {
        id: popupLayerTransition
        default property alias animaitons: popupLayerTransition.__animaions

        // Animation is an abstract class
        // property list<Animation> __animaions
         property list<QtObject> __animaions
    }
    ```

5. 具体实现案例

    ```
    //~ PopupLayerSideMenuDelegate

    // internal import
    // don't use the module import
    import "../"
    import QtQuick 2.0

    PopupLayerDelegate {

        showTransition: PopupLayerTransition {
            SequentialAnimation {
                NumberAnimation {
                    easing.overshoot: 5
                    easing.type: Easing.OutBack
                    properties: "opacity"
                    duration: 150
                }
                NumberAnimation {
                    easing.overshoot: 5
                    properties: "x"
                    duration: 150
                }
            }
        }

        hideTransition: PopupLayerTransition {
            SequentialAnimation {
                NumberAnimation {
                    easing.overshoot: 5
                    properties: "x"
                    duration: 150
                }
                NumberAnimation {
                    easing.overshoot: 5
                    easing.type: Easing.OutBack
                    properties: "opacity"
                    duration: 100
                }
            }
        }

        hideChanges: [
            PropertyChanges {
                target: popupItem
                x: -popupItem.width
            },
            PropertyChanges {
                target: maskItem
                opacity: 0
            }
        ]

        showChanges: [
            PropertyChanges {
                target: popupItem
                x: 0
            },
            PropertyChanges {
                target: maskItem
                opacity: 1
            }
        ]
    }
    ```

6. 如何使用

```
PopupLayer{
    id: optionsMenu

    popupItem.width: page.width
    popupItem.height: page.width < page.height
                      ? page.width * 0.5
                      : page.height * 0.3

    delegate: PopupLayerBottomMenuDelegate {
        // 必须指定 popupItem 和 maskItem
        popupItem: optionsMenu.popupItem
        maskItem: optionsMenu
    }

    Item {
        anchors.fill: parent
        Button {
            anchors.centenIn: parent
            text: "close"
            onClicked: {
                optionsMenu.close();
            }
        }
    }
}
```


7. 在 QML 实现动画的总结

    1. 确定要对谁实施动画。（target）。

    2. 写状态，当 target 处于某状态时，其属性的值。

    3. 写各个状态的过度。

    4. 完善过度中的动画。
