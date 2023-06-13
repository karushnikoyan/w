import 'package:equatable/equatable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


enum WebViewStage {
  loading,
  display,
}

class WebViewState extends Equatable {
  final WebViewStage stage;

  final String url;

  final InAppWebViewController webViewController;

  const WebViewState(
      {required this.stage, required this.url,  required this.webViewController});

  WebViewState copyWith({
    WebViewStage? stage,
    String? url,
    InAppWebViewController? webViewController,
  }) {
    return WebViewState(
      stage: stage ?? this.stage,
      url: url ?? this.url,
      webViewController: webViewController ?? this.webViewController,
    );
  }

  @override
  List<Object?> get props => [stage, url, webViewController];
}
