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

package org.gdpurjyfs.wellchat;



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
import android.os.Bundle;

//import org.gdpurjyfs.sparrow;

public class WellChatActivity extends org.qtproject.qt5.android.bindings.QtActivity
{
//    @Override
//    public void onCreate (Bundle savedInstanceState){
//        System.out.println("这里竟然不能有其他复杂的函数操作，会闪退的。");
//        super.onCreate(savedInstanceState);
//        org.gdpurjyfs.sparrow.QtBridgingAndroid.Init(this);
//    }

    public WellChatActivity()
    {
        org.gdpurjyfs.sparrow.QtBridgingAndroid.Init(this);
    }

}
