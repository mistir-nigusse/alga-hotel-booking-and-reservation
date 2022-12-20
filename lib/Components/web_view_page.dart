import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:nearby_hotel_detction_booking_app/Costants/constants.dart';

class Connectivity extends StatefulWidget {
  @override
  _ConnectivityState createState() => _ConnectivityState();
}

class _ConnectivityState extends State<Connectivity> {
  @override
  Widget build(BuildContext context) {
    Color mainColor = Color(0xffC16A1B);
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return OfflineBuilder(
          connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                child,
                AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: connected ? Colors.transparent : Colors.white,
                    child: connected
                        ? Webview()
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(bgcolor),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Text('No Internet Connection',
                                    style: TextStyle(
                                        color: bgcolor, fontSize: 18)),
                              ],
                            ),
                          ))
              ],
            );
          },
          child: Container());
    })
        //
        );
  }
}

class Webview extends StatefulWidget {
  @override
  _WebviewState createState() => _WebviewState();
}

String useragent =
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.106 Safari/537.36";

class _WebviewState extends State<Webview> {
  InAppWebViewController? _webViewController;
  double progress = 0;
  String url = '';
  Color mainColor = Color(0xffB82A38);
  final GlobalKey webViewKey = GlobalKey();
  // Future<Directory?>? _externalDocumentsDirectory =
  //     getExternalStorageDirectory();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        userAgent: useragent,
        verticalScrollBarEnabled: false,
        cacheEnabled: false,
        supportZoom: false,
        clearCache: true,
        javaScriptEnabled: true,
        useShouldOverrideUrlLoading: true,
        useOnDownloadStart: true,
      ),
      android: AndroidInAppWebViewOptions(
        initialScale: 100,
        useShouldInterceptRequest: true,
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  PullToRefreshController? pullToRefreshController;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: bgcolor),
      onRefresh: () async {
        if (Platform.isAndroid) {
          _webViewController?.reload();
        } else if (Platform.isIOS) {
          _webViewController?.loadUrl(
              urlRequest: URLRequest(url: await _webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(children: [
            Expanded(
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "https://testsecureacceptance.cybersource.com/pay"),
                  headers: {},
                ),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController?.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController?.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController?.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = this.url;
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            ),
          ]),
          progress < 0.5
              ? Center(
                  child: CircularProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(bgcolor),
                  ),
                )
              : Center(),
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      CupertinoIcons.chevron_left,
                      color: bgcolor,
                      size: 35,
                    ),
                    onPressed: () {
                      _webViewController?.goBack();
                    }),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
