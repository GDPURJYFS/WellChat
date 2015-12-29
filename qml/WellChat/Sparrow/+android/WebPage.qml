// just for android
import QtWebView 1.0

import QtQuick 2.0
import Sparrow 1.0

/*
canGoBack : bool
canGoForward : bool
loadProgress : int
loading : bool
title : string
url : url

don't use the signal

void goBack()
void goForward()
void loadHtml(string html, url baseUrl, url unreachableUrl)
void runJavaScript(script, callback)
void reload()
void stop()

*/

Page {
    id: webPage
    readonly property alias canGoBack: webView.canGoBack
    readonly property alias canGoForward: webView.canGoForward
    readonly property alias loadProgress: webView.loadProgress
    readonly property alias loading: webView.loading
    title: webView.title
    property alias url: webView.url

    WebView {
        id: webView
        anchors.fill: parent
    }

    function goBack() { webView.goBack(); }
    function goForward() { webView.goForward(); }
    function loadHtml(html, baseUrl){ webView.loadHtml(html, baseUrl); }
    function reload() { webView.reload(); }
    function runJavaScript(script, callback) { webView.runJavaScript(script, callback); }
    function stop() { webView.stop(); }
}
