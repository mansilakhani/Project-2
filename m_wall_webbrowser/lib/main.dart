// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: WebBrowser(),
//   ));
// }
//
// class WebBrowser extends StatefulWidget {
//   const WebBrowser({Key? key}) : super(key: key);
//
//   @override
//   State<WebBrowser> createState() => _WebBrowserState();
// }
//
// class _WebBrowserState extends State<WebBrowser> {
//   InAppWebViewController? inAppWebViewController;
//   double progress = 0;
//
//   TextEditingController searchController = TextEditingController();
//   String searchtext = "";
//
//   late PullToRefreshOptions pullToRefreshController;
//
//   List<String> allBookmarkes = [];
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         //return false;
//         if (await inAppWebViewController!.canGoBack()) {
//           /// stay in app
//           return false;
//         } else {
//           /// leave app
//           return false;
//         }
//       },
//       child: Scaffold(
//         //backgroundColor: Colors.blue,
//         appBar: AppBar(
//           elevation: 0,
//           // backgroundColor: Colors.white,
//           title: const Text("WebView"),
//           leading: IconButton(
//               onPressed: () {
//                 inAppWebViewController!.clearCache();
//               },
//               icon: const Icon(Icons.clear)),
//           actions: [
//             IconButton(
//                 onPressed: () async {
//                   if (await inAppWebViewController!.canGoBack()) {
//                     inAppWebViewController!.goBack();
//                   }
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back_ios,
//                 )),
//             IconButton(
//                 onPressed: () {
//                   // inAppWebViewController!.reload();
//                   if (Platform.isAndroid) {
//                     inAppWebViewController!.reload();
//                   }
//                   if (Platform.isIOS) {
//                     inAppWebViewController!.loadUrl(
//                         urlRequest: URLRequest(
//                             url: Uri.parse('https://www.google.com')));
//                   }
//                 },
//                 icon: const Icon(
//                   Icons.refresh,
//                 )),
//             IconButton(
//                 onPressed: () async {
//                   if (await inAppWebViewController!.canGoForward()) {
//                     inAppWebViewController!.goForward();
//                   }
//                 },
//                 icon: const Icon(
//                   Icons.arrow_forward_ios,
//                 )),
//           ],
//           // actions: [
//           //   IconButton(
//           //     onPressed: () async {
//           //       if (await inAppWebViewController!.canGoBack()) {
//           //         inAppWebViewController?.goBack();
//           //       }
//           //     },
//           //     icon: Icon(
//           //       Icons.arrow_back_ios,
//           //       color: Colors.black,
//           //     ),
//           //   ),
//           // ],
//         ),
//         body: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             LinearProgressIndicator(
//               value: progress,
//               color: Colors.red,
//               backgroundColor: Colors.black,
//             ),
//             Container(
//               color: Colors.white,
//               child: TextField(
//                 controller: searchController,
//                 onSubmitted: (val) async {
//                   Uri uri = Uri.parse(searchtext);
//                   if (uri.scheme.isEmpty) {
//                     uri = Uri.parse(
//                         'https://www.google.com/search?q=' + searchtext);
//                   }
//                   await inAppWebViewController!
//                       .loadUrl(urlRequest: URLRequest(url: uri));
//                 },
//                 decoration: const InputDecoration(
//                   hintText: "Search your website",
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: InAppWebView(
//                 initialUrlRequest: URLRequest(
//                   url: Uri.parse('https://www.google.com'),
//                 ),
//                 onWebViewCreated: (controller) {
//                   inAppWebViewController = controller;
//                 },
//                 onProgressChanged: (controller, progress) {
//                   setState(() => this.progress = progress / 100);
//                 },
//               ),
//             ),
//           ],
//         ),
//         floatingActionButton: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             FloatingActionButton(
//               child: Icon(Icons.bookmark_add),
//               onPressed: () {},
//             ),
//             SizedBox(width: 10),
//             FloatingActionButton(
//               child: Icon(Icons.bookmark),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey inAppWebViewKey = GlobalKey();
  InAppWebViewController? inAppWebViewController;
  double progress = 0;

  final TextEditingController searchController = TextEditingController();
  String searchedText = "";

  late PullToRefreshController pullToRefreshController;

  List<String> allBookmarks = [];

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
    ),
  );

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
              urlRequest: URLRequest(
                url: await inAppWebViewController!.getUrl(),
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView App"),
        leading: IconButton(
            onPressed: () async {
              await inAppWebViewController!.loadUrl(
                urlRequest: URLRequest(
                  url: Uri.parse('https://www.google.co.in'),
                ),
              );
            },
            icon: const Icon(Icons.home)),
        actions: [
          IconButton(
            onPressed: () async {
              if (await inAppWebViewController!.canGoBack()) {
                await inAppWebViewController!.goBack();
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          IconButton(
              onPressed: () async {
                await inAppWebViewController!.reload();
              },
              icon: const Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoForward()) {
                  await inAppWebViewController!.goForward();
                }
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            color: Colors.grey,
            backgroundColor: Colors.black,
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: searchController,
                  onSubmitted: (val) async {
                    searchedText = val;
                    Uri uri = Uri.parse(searchedText);
                    if (uri.scheme.isEmpty) {
                      uri = Uri.parse(
                          'https://www.google.com/search?q=' + searchedText);
                    }
                    await inAppWebViewController!
                        .loadUrl(urlRequest: URLRequest(url: uri));
                  },
                  decoration: const InputDecoration(
                    hintText: "Search your website ...",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              )),
          Expanded(
            flex: 15,
            child: InAppWebView(
              // key: inAppWebViewKey,
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              initialUrlRequest: URLRequest(
                url: Uri.parse('https://www.google.co.in'),
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
            onPressed: () async {
              Uri? uri = await inAppWebViewController?.getUrl();
              allBookmarks.add(uri.toString());
            },
            mini: false,
            child: const Icon(Icons.bookmark_add_outlined),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
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
