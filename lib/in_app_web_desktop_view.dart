// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class InAppWebViewsDesktop extends StatefulWidget {
//   const InAppWebViewsDesktop({super.key, required this.url});
//
//   final String url;
//
//   @override
//   InAppWebViewsDesktopState createState() => InAppWebViewsDesktopState();
// }
//
// class InAppWebViewsDesktopState extends State<InAppWebViewsDesktop> {
//   InAppWebViewController? webViewController;
//   bool isLoading = true;
//
//   Future<bool> onWillPop() async {
//     if (await webViewController?.canGoBack() ?? false) {
//       webViewController?.goBack();
//       return false;
//     } else {
//       return true;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey[800],
//         centerTitle: true,
//         title: const Text(
//           'Desktop Mode',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: WillPopScope(
//         onWillPop: onWillPop,
//         child: SafeArea(
//           child: Center(
//             child: Container(
//               constraints: BoxConstraints(
//                 maxWidth: 1200,  // Adjust to desired desktop width
//                 maxHeight: 800,  // Adjust to desired desktop height
//               ),
//               color: Colors.grey[200],
//               child: Stack(
//                 children: [
//                   InAppWebView(
//                     initialSettings: InAppWebViewSettings(
//                       mediaPlaybackRequiresUserGesture: false,
//                       useHybridComposition: true,
//                       allowsInlineMediaPlayback: true,
//                       userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
//                       // android: AndroidInAppWebViewOptions(
//                       //   useHybridComposition: true,
//                       // ),
//                       // crossPlatform: InAppWebViewOptions(
//                       //   userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
//                       //   preferredContentMode: UserPreferredContentMode.DESKTOP,
//                       // ),
//                     ),
//                     initialUrlRequest: URLRequest(
//                       url: WebUri(widget.url),
//                     ),
//                     onWebViewCreated: (controller) {
//                       webViewController = controller;
//                     },
//                     onLoadStart: (controller, url) {
//                       setState(() {
//                         isLoading = true;
//                       });
//                     },
//                     onLoadStop: (controller, url) {
//                       setState(() {
//                         isLoading = false;
//                       });
//                     },
//                   ),
//                   if (isLoading)
//                     Center(
//                       child: CircularProgressIndicator(
//                         color: Colors.blueGrey.withOpacity(.8),
//                         strokeWidth: 5,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
