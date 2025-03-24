// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gcc_portal/core/image_string.dart';
//
// Future<void> preloadSvgAssetsFunc(List<String> assetPaths) async {
//   for (final path in assetPaths) {
//     final loader = SvgAssetLoader(path);
//     await svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
//   }
// }
//
// Future<void> preLoadSVG() async {
//   await preloadSvgAssetsFunc([
//     ImageString().calculation,
//     ImageString().information,
//     ImageString().renew,
//     ImageString().login,
//     ImageString().application,
//   ]);
// }
