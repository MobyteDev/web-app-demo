import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_body.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_items.dart';
import 'package:portageur_test/presentation/utils/app_colors.dart';
import 'package:portageur_test/presentation/utils/screen_utils.dart';

class ChatMockup extends StatelessWidget {
  const ChatMockup({
    super.key,
    required this.firstBotMessage,
    required this.botQuestion,
    required this.defaultQuestion,
    required this.firstBotAnswer,
    this.question,
    this.answer,
  });

  final String firstBotMessage;
  final String botQuestion;
  final String defaultQuestion;
  final String firstBotAnswer;
  final String? question;
  final String? answer;

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.poppins(
      color: AppColors.mainTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 21 / 14,
    );
    return ChatBody(
      items: [
        BotChatItem(
          content: Text(
            firstBotMessage,
            style: textStyle,
          ),
        ),
        UserChatItem(
          content: defaultQuestion,
          ration: switch (context.deviceType) {
            LargeDeviceType() => 0.22,
            MediumDeviceType() => 0.3,
            SmallDeviceType() => 0.4,
          },
        ),
        BotChatItem(
          content: MarkdownBody(
            data: firstBotAnswer,
            styleSheet: MarkdownStyleSheet(p: textStyle),
          ),
        ),
        BotChatItem(
          content: Text(
            botQuestion,
            style: textStyle,
          ),
        ),
        if (question != null) UserChatItem(content: question!),
        if (answer != null)
          BotChatItem(
            content: MarkdownBody(
              data: answer!,
              styleSheet: MarkdownStyleSheet(
                tableHead: GoogleFonts.poppins(
                  color: AppColors.mainTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 21 / 14,
                ),
                tableBody: GoogleFonts.poppins(
                  color: AppColors.mainTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 21 / 14,
                ),
              ),
            ),
          ),
        if (answer != null)
          BotChatItem(
            content: Text(
              botQuestion,
              style: textStyle,
            ),
          ),
      ],
    );
  }
}
