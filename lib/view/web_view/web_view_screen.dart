import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../cubits/web_view/web_view_cubit.dart';
import '../../cubits/web_view/web_view_state.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WebViewCubit>(
      create: (_) => WebViewCubit(url: url),
      child: BlocBuilder<WebViewCubit, WebViewState>(builder: (context, state) {
        final cubit = context.read<WebViewCubit>();
        return SafeArea(
          child: Scaffold(
            body: WillPopScope(
              onWillPop: cubit.onBackPressed,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(children: [
                      InAppWebView(
                        initialUrlRequest:
                            URLRequest(url: Uri.parse(state.url)),
                        initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                            useShouldOverrideUrlLoading: true,
                            javaScriptCanOpenWindowsAutomatically: true,
                          ),
                        ),
                        onWebViewCreated: (controller) {
                          cubit.setUpController(controller);
                        },
                        androidOnPermissionRequest:
                            (InAppWebViewController controller, String origin,
                                List<String> resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
