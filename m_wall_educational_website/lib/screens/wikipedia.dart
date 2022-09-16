import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WikiPedia_Page extends StatefulWidget {
  const WikiPedia_Page({Key? key}) : super(key: key);

  @override
  State<WikiPedia_Page> createState() => _WikiPedia_PageState();
}

class _WikiPedia_PageState extends State<WikiPedia_Page> {
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
        backgroundColor: Colors.black,
        title: Text("WIKIPEDIA"),

        // leading: IconButton(
        //     onPressed: () async {
        //       if (await inAppWebViewController!.canGoBack()) {
        //         inAppWebViewController!.goBack();
        //       }
        //     },
        //     icon: Icon(Icons.arrow_back_ios)),
        leading: IconButton(
            onPressed: () async {
              await inAppWebViewController!.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse('https://www.wikipedia.org/'),
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
              icon: Icon(Icons.arrow_back_ios)),
          IconButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  inAppWebViewController!.reload();
                }
                if (Platform.isIOS) {
                  inAppWebViewController!.loadUrl(
                      urlRequest: URLRequest(
                          url: Uri.parse('https://www.wikipedia.org/')));
                }
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoBack()) {
                  inAppWebViewController!.goBack();
                }
              },
              icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            color: Colors.blue,
            backgroundColor: Colors.black,
          ),
          // Expanded(
          //     flex: 2,
          //     child: Padding(
          //       padding: EdgeInsets.all(5),
          //       child: TextField(
          //         controller: searchController,
          //         onSubmitted: (val) async {
          //           globals.searchtext = val;
          //           Uri uri = Uri.parse(globals.searchtext);
          //           if (uri.scheme.isEmpty) {
          //             uri = Uri.parse('https://www.w3schools.com/search?q=' +
          //                 globals.searchtext);
          //           }
          //           await inAppWebViewController!
          //               .loadUrl(urlRequest: URLRequest(url: uri));
          //         },
          //         decoration: const InputDecoration(
          //           hintText: "Search your website ...",
          //           suffixIcon: Icon(Icons.search),
          //         ),
          //       ),
          //     )),
          Expanded(
            flex: 15,
            child: InAppWebView(
              // key: inAppWebViewKey,
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              initialUrlRequest: URLRequest(
                url: Uri.parse('https://www.wikipedia.org/'),
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
            backgroundColor: Colors.black,
            onPressed: () async {
              Uri? uri = await inAppWebViewController?.getUrl();
              allBookmarks.add(uri.toString());
            },
            mini: false,
            child: const Icon(Icons.bookmark_add_outlined),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: const Text("Add Bookmarks list"),
                    content: SizedBox(
                      height: 300,
                      width: 300,
                      child: ListView.separated(
                          itemBuilder: (context, i) => ListTile(
                                title: Text(allBookmarks[i]),
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
                                color: Colors.grey,
                              ),
                          itemCount: allBookmarks.length),
                    )),
              );
            },
            child: Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}
