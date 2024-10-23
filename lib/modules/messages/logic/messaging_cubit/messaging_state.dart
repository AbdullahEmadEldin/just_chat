part of 'messaging_cubit.dart';

@immutable
sealed class MessagingState {}

final class MessagingInitial extends MessagingState {}

///
//! Changing UI states

final class SwitchSendButtonIcon extends MessagingState {
  final IconData newIcon;
  SwitchSendButtonIcon({required this.newIcon});
}

final class ReplyToMessageState extends MessagingState {

  final MessageModel replyToMessage;
  ReplyToMessageState({required this.replyToMessage});
}
final class CancelReplyToMessageState extends MessagingState {}

//! This state to update the border radius of messaging field when the msg exceed one line.
final class SetBorderRadiusToSquare extends MessagingState {}
final class SetBorderRadiusToCircle extends MessagingState {}
