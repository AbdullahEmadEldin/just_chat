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
  bool overlayOn = false;
  OverlayEntry? overlayEntry;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (overlayOn) {
          _removeOverlay();
          overlayOn = false;
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
        top: MediaQuery.of(context).size.height * 0.7,
        left: MediaQuery.of(context).size.width * 0.73,
        // right: MediaQuery.of(context).size.width * 0.1,
        child: _sendingOptions(context),
      ),
    );
    overlay.insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  FlipInY _sendingOptions(BuildContext context) {
    return FlipInY(
      duration: const Duration(milliseconds: 500),
      child: Material(
          color: ColorsManager().colorScheme.fillRed,
          shape: const StadiumBorder(),
          child: Container(
            decoration: BoxDecoration(
                color: ColorsManager().colorScheme.fillPrimary,
                borderRadius: BorderRadius.circular(8.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async => _pickFile(context, FileType.image),
                  icon: Icon(
                    CupertinoIcons.camera_fill,
                    color: ColorsManager().colorScheme.primary40,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.doc_text_fill,
                    color: ColorsManager().colorScheme.primary40,
                  ),
                ),
                IconButton(
                  onPressed: () async => _pickFile(context, FileType.video),
                  icon: Icon(
                    CupertinoIcons.videocam_fill,
                    color: ColorsManager().colorScheme.primary40,
                  ),
                ),
                IconButton(
                  onPressed: () async => _pickFile(context, FileType.audio),
                  icon: Icon(
                    CupertinoIcons.music_house_fill,
                    color: ColorsManager().colorScheme.primary40,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _pickFile(BuildContext context, FileType fileType) async {
    await FilePicker.platform.pickFiles(type: fileType).then((value) {
      _removeOverlay();
      if (value != null) {
        context.pushNamed(PreviewFileScreen.routeName,
            arguments: PreviewFileArgs(
              imagePath: value.files.first.path!,
              fileType: fileType,
              sendCubitContext: context,
            ));

        //value.files.first.extension;
      }
    });
  }
}
