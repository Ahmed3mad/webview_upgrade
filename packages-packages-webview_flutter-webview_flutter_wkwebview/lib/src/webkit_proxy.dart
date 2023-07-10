// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'common/instance_manager.dart';
import 'foundation/foundation.dart';
import 'web_kit/web_kit.dart';

// This convenience method was added because Dart doesn't support constant
// function literals: https://github.com/dart-lang/language/issues/1048.
WKWebsiteDataStore _defaultWebsiteDataStore() => WKWebsiteDataStore.defaultDataStore;

WKWebView _defaultWebViewBuilder(
  WKWebViewConfiguration configuration, {
  void Function(
    String keyPath,
    NSObject object,
    Map<NSKeyValueChangeKey, Object> change,
  )
      observeValue,
  InstanceManager instanceManager,
}) =>
    WKWebView(
      configuration,
      observeValue: observeValue,
      instanceManager: instanceManager,
    );

WKWebViewConfiguration _defaultConfigurationBuilder({
  InstanceManager instanceManager,
}) =>
    WKWebViewConfiguration(instanceManager: instanceManager);

WKScriptMessageHandler _defaultScriptMessageHandlerBuilder({
  @required
      void Function(
    WKUserContentController userContentController,
    WKScriptMessage message,
  )
          didReceiveScriptMessage,
}) =>
    WKScriptMessageHandler(didReceiveScriptMessage: didReceiveScriptMessage);

WKNavigationDelegate _defaultNavigationDelegateBuilder({
  void Function(WKWebView webView, String url) didFinishNavigation,
  void Function(WKWebView webView, String url) didStartProvisionalNavigation,
  Future<WKNavigationActionPolicy> Function(
    WKWebView webView,
    WKNavigationAction navigationAction,
  )
      decidePolicyForNavigationAction,
  void Function(WKWebView webView, NSError error) didFailNavigation,
  void Function(WKWebView webView, NSError error) didFailProvisionalNavigation,
  void Function(WKWebView webView) webViewWebContentProcessDidTerminate,
}) =>
    WKNavigationDelegate(
      didFinishNavigation: didFinishNavigation,
      didStartProvisionalNavigation: didStartProvisionalNavigation,
      decidePolicyForNavigationAction: decidePolicyForNavigationAction,
      didFailNavigation: didFailNavigation,
      didFailProvisionalNavigation: didFailProvisionalNavigation,
      webViewWebContentProcessDidTerminate: webViewWebContentProcessDidTerminate,
    );

WKUIDelegate _defaultUIDelegateBuilder({
  void Function(
    WKWebView webView,
    WKWebViewConfiguration configuration,
    WKNavigationAction navigationAction,
  )
      onCreateWebView,
}) =>
    WKUIDelegate(onCreateWebView: onCreateWebView);

/// Handles constructing objects and calling static methods for the WebKit
/// native library.
///
/// This class provides dependency injection for the implementations of the
/// platform interface classes. Improving the ease of unit testing and/or
/// overriding the underlying WebKit classes.
///
/// By default each function calls the default constructor of the WebKit class
/// it intends to return.
class WebKitProxy {
  /// Constructs a [WebKitProxy].
  const WebKitProxy(
      {this.createWebView = _defaultWebViewBuilder,
      this.createWebViewConfiguration = _defaultConfigurationBuilder,
      this.createScriptMessageHandler = _defaultScriptMessageHandlerBuilder,
      this.defaultWebsiteDataStore = _defaultWebsiteDataStore,
      this.createNavigationDelegate = _defaultNavigationDelegateBuilder,
      this.createUIDelegate = _defaultUIDelegateBuilder});

  /// Constructs a [WKWebView].
  final WKWebView Function(
    WKWebViewConfiguration configuration, {
    void Function(
      String keyPath,
      NSObject object,
      Map<NSKeyValueChangeKey, Object> change,
    )
        observeValue,
    InstanceManager instanceManager,
  }) createWebView;

  /// Constructs a [WKWebViewConfiguration].
  final WKWebViewConfiguration Function({
    InstanceManager instanceManager,
  }) createWebViewConfiguration;

  /// Constructs a [WKScriptMessageHandler].
  final WKScriptMessageHandler Function({
    @required
        void Function(
      WKUserContentController userContentController,
      WKScriptMessage message,
    )
            didReceiveScriptMessage,
  }) createScriptMessageHandler;

  /// The default [WKWebsiteDataStore].
  final WKWebsiteDataStore Function() defaultWebsiteDataStore;

  /// Constructs a [WKNavigationDelegate].
  final WKNavigationDelegate Function({
    void Function(WKWebView webView, String url) didFinishNavigation,
    void Function(WKWebView webView, String url) didStartProvisionalNavigation,
    Future<WKNavigationActionPolicy> Function(
      WKWebView webView,
      WKNavigationAction navigationAction,
    )
        decidePolicyForNavigationAction,
    void Function(WKWebView webView, NSError error) didFailNavigation,
    void Function(WKWebView webView, NSError error) didFailProvisionalNavigation,
    void Function(WKWebView webView) webViewWebContentProcessDidTerminate,
  }) createNavigationDelegate;

  /// Constructs a [WKUIDelegate].
  final WKUIDelegate Function({
    void Function(
      WKWebView webView,
      WKWebViewConfiguration configuration,
      WKNavigationAction navigationAction,
    )
        onCreateWebView,
  }) createUIDelegate;
}
