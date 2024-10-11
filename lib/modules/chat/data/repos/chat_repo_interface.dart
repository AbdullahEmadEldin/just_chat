import 'package:just_chat/modules/chat/data/models/chat_model.dart';

/// This class represents an interface for the chat repository.
/// to make it easy to switch between backend services implementations.
abstract class ChatRepoInterface {
  Stream<List<ChatModel>?> getAllChats();
}
