import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/theme/colors/colors_manager.dart';
import 'package:just_chat/core/widgets/custom_toast.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';

class LongPressSelectableWidget extends StatefulWidget {
  final bool myAlignment;
  final MessageModel message;
  final Widget child;
  const LongPressSelectableWidget({
    super.key,
    required this.myAlignment,
    required this.message,
    required this.child,
  });

  @override
  State<LongPressSelectableWidget> createState() =>
      _LongPressSelectableWidgetState();
}

class _LongPressSelectableWidgetState extends State<LongPressSelectableWidget>
    with SingleTickerProviderStateMixin {

  /// this will used to draw the option overlay over the message.
  OverlayEntry? _overlayEntry;
  final GlobalKey messageKey = GlobalKey();

  bool isSelected = false;



  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: messageKey,
      onLongPress: () {
        setState(() {
          isSelected = true;
          _showActionOverlay(context);
        });
      },
      onLongPressCancel: () {
        setState(() {
          isSelected = false;
          _removeOverlay();
        });
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager().colorScheme.primary20 : null,
        ),
        child: IntrinsicWidth(
          child: widget.child,
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  _showActionOverlay(BuildContext context) {
    // Get the render object of the message
    final RenderBox renderBox =
        messageKey.currentContext?.findRenderObject() as RenderBox;
    // Get the position and size of the message widget
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (_) => _buildActionOverlay(context, position, size),
    );
    overlay.insert(_overlayEntry!);
  }

  _buildActionOverlay(BuildContext context, Offset position, Size size) {
    return Positioned(
      left: position.dx + size.width / 2 - 60, // Center the popup horizontally
      top: position.dy - 50, // Position it above the message
      child: FadeInRight(
        duration: const Duration(milliseconds: 300),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsManager().colorScheme.fillPrimary,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 1,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.myAlignment
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isSelected = false;
                          Future.delayed(const Duration(milliseconds: 300), () {
                            context
                                .read<MessagingCubit>()
                                .deleteMsg(message: widget.message);
                          });
                          _removeOverlay();
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.withOpacity(0.8),
                      ))
                  : const SizedBox.shrink(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      Clipboard.setData(
                        ClipboardData(
                          text: widget.message.content,
                        ),
                      ).then((_) {
                        showCustomToast(
                          context,
                          'Copied message',
                        );
                      });
                      isSelected = false;
                      _removeOverlay();
                    });
                  },
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSelected = false;
                      _removeOverlay();
                    });
                  },
                  icon: const Icon(
                    Icons.reply,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
