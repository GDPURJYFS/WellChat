/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the QtAndroidExtras module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL21$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 or version 3 as published by the Free
** Software Foundation and appearing in the file LICENSE.LGPLv21 and
** LICENSE.LGPLv3 included in the packaging of this file. Please review the
** following information to ensure the GNU Lesser General Public License
** requirements will be met: https://www.gnu.org/licenses/lgpl.html and
** http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** As a special exception, The Qt Company gives you certain additional
** rights. These rights are described in The Qt Company LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** $QT_END_LICENSE$
**
****************************************************************************/

package org.GDPURJYFS.WellChat;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.app.Activity;
import android.view.Window;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.RelativeLayout;
import android.view.ViewTreeObserver;
import android.graphics.Rect;
import android.view.ViewGroup;

public class NotificationClient extends org.qtproject.qt5.android.bindings.QtActivity
{
    private static NotificationManager m_notificationManager;
    private static Notification.Builder m_builder;
    private static NotificationClient m_instance;
    private static Rect m_keyboardRectangle;
    private static boolean hasListenVirtualKeyboard = false;

    public NotificationClient()
    {
        m_instance = this;
    }

    private static View getRootView(Activity context)
    {
        return ((ViewGroup)context.findViewById(android.R.id.content)).getChildAt(0);
    }

    public static void notify(String notifyText)
    {
        if (m_notificationManager == null) {
            m_notificationManager = (NotificationManager)m_instance.getSystemService(Context.NOTIFICATION_SERVICE);
            m_builder = new Notification.Builder(m_instance);
            m_builder.setSmallIcon(R.drawable.icon);
            m_builder.setContentTitle("WellChat");
        }

        System.out.println("set setContentText");
        m_builder.setContentText(notifyText);
        m_notificationManager.notify(1, m_builder.build());
    }

    public static void listenKeyboardHeight() {
        if(!hasListenVirtualKeyboard) {
            final View myRootView = getRootView(m_instance);
            myRootView.getViewTreeObserver().addOnGlobalLayoutListener(
            new ViewTreeObserver.OnGlobalLayoutListener() {
                @Override
                public void onGlobalLayout() {

                    Rect outRect = new Rect();
                    m_instance.getWindow().getDecorView().getWindowVisibleDisplayFrame(outRect);

                    m_keyboardRectangle = new Rect();
                    myRootView.getWindowVisibleDisplayFrame(m_keyboardRectangle);

                    int screenHeight = myRootView.getRootView().getHeight();
                    // 小于100 就不行了
                    // 这里还要减去状态栏的高度
                    // 魔幻数字
                    int magic = 5;
                    int virtualKeyboardHeight = screenHeight - (m_keyboardRectangle.bottom - m_keyboardRectangle.top) - outRect.top - magic;

                    if( virtualKeyboardHeight < 100 ) {
                        virtualKeyboardHeight = 0;
                    }

                    org.GDPURJYFS.Sparrow.QtNativeForAndroid.notifiedKeyboardRectangle(
                            m_keyboardRectangle.centerX(),
                            m_keyboardRectangle.centerY(),
                            m_keyboardRectangle.width(),
                            virtualKeyboardHeight);
                }
            });
            hasListenVirtualKeyboard = true;
        }
    }
}
