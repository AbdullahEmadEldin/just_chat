import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../shared/preview_file.dart';

class SendingMediaWidget extends StatefulWidget {
  const SendingMediaWidget({super.key});

  @override
  State<SendingMediaWidget> createState() => _SendingMediaWidgetState();
}

class _SendingMediaWidgetState extends State<SendingMediaWidget> {
  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  bool overlayOn = false;
  OverlayEntry? overlayEntry;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (overlayOn) {
          _removeOverlay();
        } else {
          _overlay(context);
        }
      },
      icon: Icon(CupertinoIcons.paperclip,
          color: ColorsManager().colorScheme.primary40),
    );
  }

  _overlay(BuildContext context) {
    overlayOn = true;
    final overlay = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        top: MediaQuery.of(context).size.height * 0.64,
        left: MediaQuery.of(context).size.width * 0.7,
        // right: MediaQuery.of(context).size.width * 0.1,
        child: _sendingOptions(context),
      ),
    );
    overlay.insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayOn = false;
    overlayEntry?.remove();
    overlayEntry = null;
  }

  FlipInY _sendingOptions(BuildContext context) {
    return FlipInY(
      duration: const Duration(milliseconds: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _optionTile(context,
              icon: CupertinoIcons.camera_fill, fileType: FileType.image),
          _optionTile(context,
              icon: CupertinoIcons.doc_text_fill, fileType: FileType.image),
          _optionTile(context,
              icon: CupertinoIcons.videocam_fill, fileType: FileType.video),
          _optionTile(context,
              icon: CupertinoIcons.music_house_fill, fileType: FileType.audio),
        ],
      ),
    );
  }

  Container _optionTile(
    BuildContext context, {
    required IconData icon,
    required FileType fileType,
  }) {
    return Container(
      padding: EdgeInsets.all(4.r),
      margin: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: ColorsManager().colorScheme.fillPrimary,
      ),
      child: IconButton(
        onPressed: () async => _pickFile(context, fileType),
        icon: Icon(
          icon,
          color: ColorsManager().colorScheme.primary40,
        ),
      ),
    );
  }

  _pickFile(BuildContext context, FileType fileType) async {
    await FilePicker.platform.pickFiles(type: fileType).then((value) {
      _removeOverlay();
      if (value != null) {
        context.pushNamed(PreviewFileScreen.routeName,
            arguments: PreviewFileArgs(
              filePath: value.files.first.path!,
              fileType: fileType,
              sendCubitContext: context,
            ));

        //value.files.first.extension;
      }
    });
  }
}
