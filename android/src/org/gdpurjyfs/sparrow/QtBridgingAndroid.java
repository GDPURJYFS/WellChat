/*
 * Copyright (c) <2015> <copyright qyvlik>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
*/

/*!
 * Activity 先于 Qt 加载
 * 1. 在 Activity OnCreate 中调用 QtBridgingAndroid::Init，然后进入Qt::main
 * 2. 在 Qt::main 中注册 Java 的 native 函数 QtBridgingAndroid::notifiedKeyboardRectangle
 * 3. 在 Qt::main 通过调用 Java::QtBridgingAndroid::listenKeyboardHeight 注入监听键盘事件
 * 4. 在 Qt::main 加载 QML。
*/

package org.gdpurjyfs.sparrow;

import android.app.Notification;
import android.app.NotificationManager;
import android.content.Context;
import android.app.Activity;
import android.os.Bundle;
import android.graphics.Color;
import android.app.Activity;
import android.view.Window;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.RelativeLayout;
import android.view.ViewTreeObserver;
import android.graphics.Rect;
import android.view.ViewGroup;

import java.lang.Thread;

//! http://blog.csdn.net/foruok/article/details/46323129
class SetStatusBarColorRunnable implements Runnable
{
    private Activity m_activity;
    private int m_color;
    public SetStatusBarColorRunnable(Activity activity, int color) {
        m_activity = activity;
        m_color = color;
    }
    // this method is called on Android Ui Thread
    @Override
    public void run() {
        m_activity.getWindow().setStatusBarColor(m_color);
    }
}

public class QtBridgingAndroid
{   
    public static Activity instanceActivity;
    
    private static NotificationManager notificationManager;
    private static Notification.Builder builder;
    private static Rect keyboardRectangle;
    private static boolean hasListenVirtualKeyboard = false;
    
    // allow Qt call this static function
    // api 19
    // @TargetApi(Build.VERSION_CODES.LOLLIPOP)
    // android.view.ViewRootImpl$CalledFromWrongThreadException
    //! http://daydayup1989.iteye.com/blog/784831
    public static void setStatusBarColor(String colorString) {
        if(instanceActivity != null) {
            try {
                System.out.println("colorString: " + colorString);
                int color = Color.parseColor(colorString);
                System.out.println("color: " + color);
                instanceActivity.runOnUiThread(new SetStatusBarColorRunnable(instanceActivity,
                                                                             color));
            } catch(IllegalArgumentException e) {
                e.printStackTrace();
            } catch(Exception e1) {
                e1.printStackTrace();
            }
        }
    }

    // allow Qt call this static function
    public static void notify(String notifyText)
    {
        if (notificationManager == null) {
            notificationManager = (NotificationManager)instanceActivity.getSystemService(Context.NOTIFICATION_SERVICE);
            builder = new Notification.Builder(instanceActivity);
            builder.setSmallIcon(org.gdpurjyfs.wellchat.R.drawable.icon);
            builder.setContentTitle("WellChat");
        }

        System.out.println("set setContentText");
        builder.setContentText(notifyText);
        notificationManager.notify(1, builder.build());
    }
    
    private static View getRootView(Activity context)
    {
        return ((ViewGroup)context.findViewById(android.R.id.content)).getChildAt(0);
    }
    

    // 确保Qt调用时，只注入一次键盘监听事件
    public static void listenKeyboardHeight() {
        if(!hasListenVirtualKeyboard) {
            final View myRootView = getRootView(instanceActivity);
            myRootView.getViewTreeObserver().addOnGlobalLayoutListener(
            new ViewTreeObserver.OnGlobalLayoutListener() {
                @Override
                public void onGlobalLayout() {

                    Rect outRect = new Rect();
                    instanceActivity.getWindow().getDecorView().getWindowVisibleDisplayFrame(outRect);

                    keyboardRectangle = new Rect();
                    myRootView.getWindowVisibleDisplayFrame(keyboardRectangle);

                    int screenHeight = myRootView.getRootView().getHeight();
                    // 小于100 就不行了
                    // 这里还要减去状态栏的高度
                    // 魔幻数字
                    int magic = 5;
                    int virtualKeyboardHeight = screenHeight - (keyboardRectangle.bottom - keyboardRectangle.top) 
                                                - outRect.top - magic;

                    if( virtualKeyboardHeight < 100 ) {
                        virtualKeyboardHeight = 0;
                    }

                    // java 通知 Qt 键盘改变了
                    notifiedKeyboardRectangle(
                            keyboardRectangle.centerX(),
                            keyboardRectangle.centerY(),
                            keyboardRectangle.width(),
                            virtualKeyboardHeight);
                }
            });
            hasListenVirtualKeyboard = true;
        }
    }
    
    // allow java call this native method
    public static native void notifiedKeyboardRectangle(int x, int y,
                                                        int width, int height);
    
    // Java call this method and init this static Bridge Class
    public static void Init(Activity instanceActivity) {
        QtBridgingAndroid.instanceActivity = instanceActivity;

        System.out.println("QtBridgingAndroid::Init");
    }
}
