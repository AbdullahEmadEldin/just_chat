// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// class NetworkHelper {
//   /// This method convert the selected image to MultipartFile
//   /// which the acceptable format to be sent to the server
//   static Future<MultipartFile> uploadImageToApi(XFile? image) async {
//     // if the user didn't select an image we will use the default avatar as his profile pic.
//     if (image == null) {
//       final ByteData byteData = await rootBundle.load(AppAssets.images.avatar);
//       final Uint8List imageData = byteData.buffer.asUint8List();

//       final MultipartFile multipartFile = MultipartFile.fromBytes(
//         imageData,
//         filename: 'avatar.jpg',
//         // contentType: MediaType('image', 'jpg'),
//       );
//       return multipartFile;
//     } else
//       return MultipartFile.fromFile(
//         image.path,
//         filename: image.path.split('/').last,
//       );
//   }

//   /// This method is used to launch the url in external website or app
//   static Future<void> customLaunchUrl(
//     BuildContext context, {
//     required String url,
//   }) async {
//     Uri uri = Uri.parse(url);

//     /// before launching the url, give permission of internet access in Android Manifest file.
//     bool canLaunch = await canLaunchUrl(uri);
//     try {
//       if (canLaunch) {
//         await launchUrl(
//           uri,
//           mode: LaunchMode.externalApplication,
//         );
//       } else {
//         showToast(context, 'Could not launch url', isError: true);
//       }
//     } on Exception catch (e) {
//       showToast(context, e.toString(), isError: true);
//     }
//   }

//   /// This method to get the image bytes from it's URL as Uint8List to store it as BLOB in SQLite database.
//   ///
//   static Future<Uint8List?> getImageBytesFromResponse(String? imageUrl) async {
//     if (imageUrl == null) {
//       return null;
//     }
//     final response = await DioConsumer().get(
//         path: imageUrl, options: Options(responseType: ResponseType.bytes));
//     print(
//         '============================>>>> Convert image ======= ${response.runtimeType}');
//     return response; // This returns the image as Uint8List
//   }
// }
