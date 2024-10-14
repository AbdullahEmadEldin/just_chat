import '../models/message_model.dart';

abstract class MsgsRepoInterface {
  Stream<List<MessageModel>?> getChatMessages(String chatId);
  void sendMessage({required String chatId, required MessageModel message});
}
