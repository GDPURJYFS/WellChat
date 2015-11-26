import QtQuick 2.0
import QtQuick.Controls 1.2
import QtWebKit 3.0
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
void reload()
void stop()
void runJavaScript(script, callback)
*/

Page {
    id: webPage
    readonly property alias canGoBack: webView.canGoBack
    readonly property alias canGoForward: webView.canGoForward
    readonly property alias loadProgress: webView.loadProgress
    readonly property alias loading: webView.loading
    title: webView.title
    property alias url: webView.url

    //@disable-check M324
    WebView {
        id: webView
        anchors.fill: parent
    }

    function goBack() { webView.goBack(); }
    function goForward() { webView.goForward(); }
    function loadHtml(html, baseUrl, unreachableUrl){ webView.loadHtml(html, baseUrl, unreachableUrl); }

    function runJavaScript(script, callback) {
        throw "QtWebView 1.0 not install";
    }

    function reload() { webView.reload(); }
    function stop() { webView.stop(); }
}
