import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portageur_test/presentation/utils/app_colors.dart';
import 'package:portageur_test/presentation/utils/app_images.dart';

/// Base class of chat items
sealed class ChatItem<T> extends StatelessWidget {
  const ChatItem({super.key});

  abstract final bool isSender;
  abstract final T content;
}

/// UserChatItem is the representer of a sender
class UserChatItem extends ChatItem<String> {
  const UserChatItem({
    super.key,
    required this.content,
    this.ration = 0.22,
  });

  @override
  final bool isSender = true;

  @override
  final String content;

  final double ration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * ration,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            content,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 21 / 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 32,
          width: 32,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.green,
          ),
          child: Image.asset(AppImages.user),
        ),
      ],
    );
  }
}

/// BotChatItem is the representer of a receiver
class BotChatItem extends ChatItem<Widget> {
  const BotChatItem({
    super.key,
    required this.content,
  });

  @override
  final bool isSender = false;

  @override
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.grey,
            border: Border.all(color: AppColors.green),
          ),
          child: Image.asset(AppImages.bot),
        ),
        const SizedBox(width: 12),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.45,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: content,
        ),
      ],
    );
  }
}
