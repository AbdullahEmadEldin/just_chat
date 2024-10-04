import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_chat/core/constants/constants.dart';

class NetworkHelper {
  /// This method convert the selected image to MultipartFile
  /// which the acceptable format to be sent to the server
  Future<String> uploadImageToFirebase(XFile image) async {
    try {
      // Convert XFile to File
      File file = File(image.path);

      // Create a reference to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('${AppConstants.uploadsPath}/${image.name}');

      // Upload the file to Firebase Storage
      await storageRef.putFile(file);

      // Get the download URL of the uploaded file
      String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;}
  }

  /// This method is used to launch the url in external website or app
  // static Future<void> customLaunchUrl(
  //   BuildContext context, {
  //   required String url,
  // }) async {
  //   Uri uri = Uri.parse(url);

  //   /// before launching the url, give permission of internet access in Android Manifest file.
  //   bool canLaunch = await canLaunchUrl(uri);
  //   try {
  //     if (canLaunch) {
  //       await launchUrl(
  //         uri,
  //         mode: LaunchMode.externalApplication,
  //       );
  //     } else {
  //       showToast(context, 'Could not launch url', isError: true);
  //     }
  //   } on Exception catch (e) {
  //     showToast(context, e.toString(), isError: true);
  //   }
  // }

  /// This method to get the image bytes from it's URL as Uint8List to store it as BLOB in SQLite database.
  ///
  // static Future<Uint8List?> getImageBytesFromResponse(String? imageUrl) async {
  //   if (imageUrl == null) {
  //     return null;
  //   }
  //   final response = await DioConsumer().get(
  //       path: imageUrl, options: Options(responseType: ResponseType.bytes));
  //   print(
  //       '============================>>>> Convert image ======= ${response.runtimeType}');
  //   return response; // This returns the image as Uint8List
  // }
}
