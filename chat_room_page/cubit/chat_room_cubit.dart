import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portageur_test/domain/entities/question.dart';
import 'package:portageur_test/domain/entities/suggestions.dart';
import 'package:portageur_test/domain/repository/chat_repository.dart';

part 'chat_room_state.dart';
part 'chat_room_cubit.freezed.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit(this._chatRepository) : super(ChatRoomState());

  final ChatRepository _chatRepository;

  String _code = '';

  Future<void> getFirstAnswer(String q) async {
    try {
      final companies = await _chatRepository.getCompanies(query: q);
      _code = companies.first.code;
      final data = await _chatRepository.getQuestionAnswer(_code, 1);
      emit(
        state.copyWith(
          chatFirstMessage: ChatFirstMessage(
            firstAnswerText: data.result.answer,
            companyName: companies.first.name,
          ),
        ),
      );
      await getSuggestions(1);
    } catch (e, s) {
      log(
        "Error occurred while receiving first answer",
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> getSuggestions(int qid) async {
    try {
      final suggestions =
          await _chatRepository.getSuggestedQuestions(_code, qid);
      emit(
        state.copyWith(
          chatFooterData: ChatFooterData.fromSuggestions(suggestions),
        ),
      );
    } catch (e, s) {
      log(
        "Error occurred while receiving suggestions",
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> getAnswerText(Question question) async {
    try {
      emit(
        state.copyWith(questionText: question.prompt),
      );
      final data = await _chatRepository.getQuestionAnswer(_code, question.qid);
      emit(
        state.copyWith(answerText: data.result.answer),
      );
    } catch (e, s) {
      log(
        'Error occurred while receiving answer text',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<void> onButtonClick(Question question) async {
    if (question.skip == 1) {
      //skip and go to next level
      await getSuggestions(question.qid);
    } else {
      getAnswerText(question);
    }
  }
}
