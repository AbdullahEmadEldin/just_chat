import '../models/message_model.dart';

abstract class MsgsRepoInterface {
  Stream<List<MessageModel>?> getChatMessages(String chatId);
  void sendMessage({required MessageModel message});
  void deleteMsg({required String chatId, required MessageModel message});
  Future<void> markMsgsAsSeen({
    required String chatId,
  });
}
