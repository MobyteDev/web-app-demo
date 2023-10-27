import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/cubit/chat_room_cubit.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_body.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_footer.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_header.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_items.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_mockup.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ChatHeader(
            onSearch: (q) =>
                context.read<ChatRoomCubit>().getFirstAnswer('Apple'),
          ),
          BlocBuilder<ChatRoomCubit, ChatRoomState>(
            builder: (_, state) => Expanded(
              child: state.chatFirstMessage == null
                  ? const ChatBody(
                      items: [
                        BotChatItem(
                          content:
                              Text("Let's get started. Enter company name."),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ChatMockup(
                            firstBotAnswer:
                                state.chatFirstMessage!.firstAnswerText,
                            firstBotMessage:
                                "Let's get started. Enter company name.",
                            botQuestion: "What do you want to look at next?",
                            defaultQuestion:
                                "What are the important ESG issues surrounding ${state.chatFirstMessage!.companyName}?",
                            question: state.questionText,
                            answer: state.answerText,
                          ),
                        ),
                        if (state.chatFooterData != null)
                          ChatFooter(
                            chatFooterData: state.chatFooterData!,
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
