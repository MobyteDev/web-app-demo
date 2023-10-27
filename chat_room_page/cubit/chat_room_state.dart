part of 'chat_room_cubit.dart';

@freezed
class ChatRoomState with _$ChatRoomState {
  factory ChatRoomState({
    ChatFirstMessage? chatFirstMessage,
    ChatFooterData? chatFooterData,
    String? questionText,
    String? answerText,
  }) = _ChatRoomState;
}

final class ChatFirstMessage {
  final String firstAnswerText;
  final String companyName;
  const ChatFirstMessage({
    required this.firstAnswerText,
    required this.companyName,
  });
}

final class ChatFooterData {
  final Question? secondLayerQuestion;
  final Question? thirdLayerQuestion;
  final List<Question> variants;

  ChatFooterData({
    required this.secondLayerQuestion,
    required this.thirdLayerQuestion,
    required this.variants,
  });

  factory ChatFooterData.fromSuggestions(Suggestions suggestions) {
    return ChatFooterData(
      secondLayerQuestion: suggestions.level1
          ?.firstWhereOrNull((element) => element.highlight == 1),
      thirdLayerQuestion: suggestions.level2
          ?.firstWhereOrNull((element) => element.highlight == 1),
      variants:
          suggestions.level3 ?? suggestions.level2 ?? suggestions.level1 ?? [],
    );
  }
}
