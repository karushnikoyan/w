import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'web_view_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  final String url;

  WebViewCubit({required this.url})
      : super(WebViewState(
            stage: WebViewStage.loading,
            url: url,
            webViewController: InAppWebViewController(0,InAppWebView()))) ;

  Future<bool> onBackPressed() async {
    state.webViewController.goBack();
    return false;
  }

  setUpController(InAppWebViewController controller) {
   emit(state.copyWith(webViewController: controller));
  }
}
