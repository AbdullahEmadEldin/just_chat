import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_chat/core/constants/constants.dart';
import 'package:just_chat/core/constants/image_assets.dart';
import 'package:path_provider/path_provider.dart';

class NetworkHelper {
  /// This method convert the selected image to MultipartFile
  /// which the acceptable format to be sent to the server
  static Future<String?> uploadImageToFirebase(XFile? image) async {
    try {
      File imageFile;
      Reference storageRef;
      if (image == null) {
        imageFile = await getImageFileFromAssets(ImagesAssets.profileHolder);
        storageRef = FirebaseStorage.instance
            .ref()
            .child('${AppConstants.uploadsPath}/${imageFile.path}');
      } else {
        imageFile = File(image.path);
        if (await imageFile.exists()) {
          print('File ************************************exists: ${imageFile.path}');
        }
        // Create a reference to Firebase Storage
        storageRef = FirebaseStorage.instance.ref().child(
            '${AppConstants.uploadsPath}/${DateTime.now().millisecondsSinceEpoch.toString()}_${imageFile.path.split('/').last}');
      }

      // Upload the file to Firebase Storage
      await storageRef.putFile(imageFile);

      // Get the download URL of the uploaded file
      String downloadURL = await storageRef.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  static Future<File> getImageFileFromAssets(String imagePath) async {
    final ByteData byteData = await rootBundle.load(ImagesAssets.profileHolder);
    final Uint8List imageData = byteData.buffer.asUint8List();

    // Get a temporary directory
    final tempDir = await getTemporaryDirectory();
    final file =
        await File('${tempDir.path}/${ImagesAssets.profileHolder}').create();
    file.writeAsBytesSync(imageData);
    return file;
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
