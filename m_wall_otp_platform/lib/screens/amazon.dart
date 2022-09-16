import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Amazon extends StatefulWidget {
  const Amazon({Key? key}) : super(key: key);

  @override
  State<Amazon> createState() => _AmazonState();
}

class _AmazonState extends State<Amazon> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;
  TextEditingController searchController = TextEditingController();

  // String search = "";
  List<String> allBookmarks = [];
  double progress = 0;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.blue),
        onRefresh: () async {
          if (Platform.isAndroid) {
            inAppWebViewController!.reload();
          }
          if (Platform.isIOS) {
            inAppWebViewController!.loadUrl(
                urlRequest:
                    URLRequest(url: await inAppWebViewController!.getUrl()));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Amazon"),
        leading: IconButton(
            onPressed: () async {
              await inAppWebViewController!.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse('https://www.amazon.in/'),
                ),
              );
            },
            icon: const Icon(Icons.home)),
        actions: [
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoBack()) {
                  inAppWebViewController!.goBack();
                }
              },
              icon: const Icon(Icons.arrow_back_ios)),
          IconButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  inAppWebViewController!.reload();
                }
                if (Platform.isIOS) {
                  inAppWebViewController!.loadUrl(
                      urlRequest:
                          URLRequest(url: Uri.parse('https://www.amazon.in/')));
                }
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                inAppWebViewController!.goBack();
              }
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            color: Colors.blue,
            backgroundColor: Colors.black,
          ),
          Expanded(
            flex: 15,
            child: InAppWebView(
              // key: inAppWebViewKey,
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              initialUrlRequest: URLRequest(
                url: Uri.parse('https://www.amazon.in/'),
              ),
              onWebViewCreated: (controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged: (controller, progress) {
                setState(() => this.progress = progress / 100);
              },
              onLoadStop: (controller, url) async {
                await pullToRefreshController.endRefreshing();
                setState(() {});
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () async {
              Uri? uri = await inAppWebViewController?.getUrl();
              allBookmarks.add(uri.toString());
            },
            mini: false,
            child: const Icon(Icons.bookmark_add_outlined),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    backgroundColor: Colors.amberAccent,
                    title: const Text(
                      "Add Bookmarks list",
                      style: TextStyle(color: Colors.white),
                    ),
                    content: SizedBox(
                      height: 300,
                      width: 300,
                      child: ListView.separated(
                          itemBuilder: (context, i) => ListTile(
                                title: Text(
                                  allBookmarks[i],
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () async {
                                  Navigator.of(context).pop();

                                  await inAppWebViewController!.loadUrl(
                                    urlRequest: URLRequest(
                                      url: Uri.parse(allBookmarks[i]),
                                    ),
                                  );
                                },
                              ),
                          separatorBuilder: (context, i) => const Divider(
                                indent: 20,
                                endIndent: 20,
                                color: Colors.black,
                              ),
                          itemCount: allBookmarks.length),
                    )),
              );
            },
            child: const Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}
