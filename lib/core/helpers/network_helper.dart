import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_chat/core/services/firestore_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:just_chat/core/constants/constants.dart';
import 'package:just_chat/core/constants/image_assets.dart';
import 'package:just_chat/core/widgets/custom_toast.dart';

class NetworkHelper {
  /// This method is used to upload image to Firebase Storage
  static Future<String?> uploadProfileImageToFirebase(XFile? image) async {
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
      return null;
    }
  }

  static Future<String> uploadFileToFirebase(String filePath) async {
//! Supabase =====
    //? Getting secret vars from firebase.
    final appUrl = await FirebaseGeneralServices.getAppVar(
        docName: 'supabaseVar', varName: 'appUrl');
    final anonKey = await FirebaseGeneralServices.getAppVar(
        docName: 'supabaseVar', varName: 'anonKey');
    final supabase = SupabaseClient(appUrl, anonKey);
    //? fileName to shorten the uploaded path
    final String fileName = filePath.split('/').last;

    try {
      final file = File(filePath);
      final storageResponse =
          await supabase.storage.from('uploads').upload(fileName, file);

      ///
      //? getting Url
      log('storageResponse: $storageResponse');
      final fileUrl = supabase.storage.from('uploads').getPublicUrl(fileName);
      log('=====> URL : $fileUrl');

      return fileUrl;
    } catch (e) {
      log('Error uploading record: $e');
      rethrow;
    }

//! Firebase ======
    // try {
    //   File file = File(filePath);

    //   FirebaseStorage storage = FirebaseStorage.instance;
    //   var storageRef = storage.ref(
    //       '${AppConstants.uploadsPath}/${DateTime.now().millisecondsSinceEpoch.toString()}_${filePath.split('/').last}');
    //   //
    //   await storageRef.putFile(file);
    //   //
    //   String downloadURL = await storageRef.getDownloadURL();

    //   return downloadURL;
    // } catch (e) {
    //   print('Error uploading record: $e');
    //   rethrow;
    // }
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

  // This method is used to launch the url in external website or app
  static Future<void> customLaunchUrl(
    BuildContext context, {
    required String url,
  }) async {
    Uri uri = Uri.parse(url);

    /// before launching the url, give permission of internet access in Android Manifest file.
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
      );
    } on Exception catch (e) {
      log('Error in launching url $e');
      showCustomToast(context, 'Could not launch ', isError: true);
    }
  }

}
