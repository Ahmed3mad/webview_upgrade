// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'android_webview.dart' as android_webview;

/// Handles constructing objects and calling static methods for the Android
/// WebView native library.
///
/// This class provides dependency injection for the implementations of the
/// platform interface classes. Improving the ease of unit testing and/or
/// overriding the underlying Android WebView classes.
///
/// By default each function calls the default constructor of the WebView class
/// it intends to return.
///

android_webview.WebView _createAndroidWebView({
  @required bool useHybridComposition,
}) {
  return android_webview.WebView(useHybridComposition: useHybridComposition);
}

android_webview.WebChromeClient _createAndroidWebChromeClient({
  void Function(android_webview.WebView webView, int progress)
      onProgressChanged,
  Future<List<String>> Function(
    android_webview.WebView webView,
    android_webview.FileChooserParams params,
  )
      onShowFileChooser,
}) {
  return android_webview.WebChromeClient(
      onProgressChanged: onProgressChanged,
      onShowFileChooser: onShowFileChooser);
}

android_webview.WebViewClient _createAndroidWebViewClient({
  void Function(android_webview.WebView webView, String url) onPageStarted,
  void Function(android_webview.WebView webView, String url) onPageFinished,
  void Function(
    android_webview.WebView webView,
    android_webview.WebResourceRequest request,
    android_webview.WebResourceError error,
  )
      onReceivedRequestError,
  @Deprecated('Only called on Android version < 23.')
      void Function(
    android_webview.WebView webView,
    int errorCode,
    String description,
    String failingUrl,
  )
          onReceivedError,
  void Function(
    android_webview.WebView webView,
    android_webview.WebResourceRequest request,
  )
      requestLoading,
  void Function(android_webview.WebView webView, String url) urlLoading,
}) {
  return android_webview.WebViewClient(
      onPageFinished: onPageFinished,
      onPageStarted: onPageStarted,
      onReceivedError: onReceivedError,
      requestLoading: requestLoading,
      urlLoading: urlLoading,
      onReceivedRequestError: onReceivedRequestError);
}

android_webview.FlutterAssetManager _createFlutterAssetManager() {
  return android_webview.FlutterAssetManager();
}

android_webview.JavaScriptChannel _createJavaScriptChannel(
  String channelName, {
  @required void Function(String) postMessage,
}) {
  return android_webview.JavaScriptChannel(channelName,
      postMessage: postMessage);
}

android_webview.DownloadListener _createDownloadListener({
  @required
      void Function(
    String url,
    String userAgent,
    String contentDisposition,
    String mimetype,
    int contentLength,
  )
          onDownloadStart,
}) {
  return android_webview.DownloadListener(
    onDownloadStart: onDownloadStart,
  );
}

class AndroidWebViewProxy {
  /// Constructs a [AndroidWebViewProxy].
  const AndroidWebViewProxy({
    this.createAndroidWebView = _createAndroidWebView,
    this.createAndroidWebChromeClient = _createAndroidWebChromeClient,
    this.createAndroidWebViewClient = _createAndroidWebViewClient,
    this.createFlutterAssetManager = _createFlutterAssetManager,
    this.createJavaScriptChannel = _createJavaScriptChannel,
    this.createDownloadListener = _createDownloadListener,
  });

  /// Constructs a [android_webview.WebView].
  ///
  /// Due to changes in Flutter 3.0 the [useHybridComposition] doesn't have
  /// any effect and should not be exposed publicly. More info here:
  /// https://github.com/flutter/flutter/issues/108106
  final android_webview.WebView Function({
    @required bool useHybridComposition,
  }) createAndroidWebView;

  /// Constructs a [android_webview.WebChromeClient].
  final android_webview.WebChromeClient Function({
    void Function(android_webview.WebView webView, int progress)
        onProgressChanged,
    Future<List<String>> Function(
      android_webview.WebView webView,
      android_webview.FileChooserParams params,
    )
        onShowFileChooser,
  }) createAndroidWebChromeClient;

  /// Constructs a [android_webview.WebViewClient].
  final android_webview.WebViewClient Function({
    void Function(android_webview.WebView webView, String url) onPageStarted,
    void Function(android_webview.WebView webView, String url) onPageFinished,
    void Function(
      android_webview.WebView webView,
      android_webview.WebResourceRequest request,
      android_webview.WebResourceError error,
    )
        onReceivedRequestError,
    @Deprecated('Only called on Android version < 23.')
        void Function(
      android_webview.WebView webView,
      int errorCode,
      String description,
      String failingUrl,
    )
            onReceivedError,
    void Function(
      android_webview.WebView webView,
      android_webview.WebResourceRequest request,
    )
        requestLoading,
    void Function(android_webview.WebView webView, String url) urlLoading,
  }) createAndroidWebViewClient;

  /// Constructs a [android_webview.FlutterAssetManager].
  final android_webview.FlutterAssetManager Function()
      createFlutterAssetManager;

  /// Constructs a [android_webview.JavaScriptChannel].
  final android_webview.JavaScriptChannel Function(
    String channelName, {
    @required void Function(String) postMessage,
  }) createJavaScriptChannel;

  /// Constructs a [android_webview.DownloadListener].
  final android_webview.DownloadListener Function({
    @required
        void Function(
      String url,
      String userAgent,
      String contentDisposition,
      String mimetype,
      int contentLength,
    )
            onDownloadStart,
  }) createDownloadListener;

  /// Enables debugging of web contents (HTML / CSS / JavaScript) loaded into any WebViews of this application.
  ///
  /// This flag can be enabled in order to facilitate debugging of web layouts
  /// and JavaScript code running inside WebViews. Please refer to
  /// [android_webview.WebView] documentation for the debugging guide. The
  /// default is false.
  ///
  /// See [android_webview.WebView].setWebContentsDebuggingEnabled.
  Future<void> setWebContentsDebuggingEnabled(bool enabled) {
    return android_webview.WebView.setWebContentsDebuggingEnabled(enabled);
  }
}
