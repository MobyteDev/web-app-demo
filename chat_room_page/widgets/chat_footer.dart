import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/cubit/chat_room_cubit.dart';
import 'package:portageur_test/presentation/utils/app_colors.dart';
import 'package:portageur_test/presentation/utils/app_images.dart';
import 'package:portageur_test/presentation/utils/screen_utils.dart';

class ChatFooter extends StatefulWidget {
  final ChatFooterData chatFooterData;
  const ChatFooter({
    required this.chatFooterData,
    super.key,
  });

  @override
  State<ChatFooter> createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {
  int selectedButtonIndex = -1;

  @override
  void didUpdateWidget(covariant ChatFooter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.chatFooterData != oldWidget.chatFooterData) {
      selectedButtonIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionTextStyle = GoogleFonts.poppins(
      color: AppColors.green,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 21 / 14,
    );
    final arrow = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Image.asset(AppImages.arrowCircle),
    );
    return Padding(
      padding: paddingFooter(context),
      child: Column(
        children: [
          Container(
            height: 1,
            color: AppColors.green,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                '1. What do you want to look at next?',
                style: questionTextStyle,
              ),
              if (widget.chatFooterData.secondLayerQuestion != null) ...[
                arrow,
                Text(
                  '2. ${widget.chatFooterData.secondLayerQuestion!.prompt}',
                  style: questionTextStyle,
                ),
              ],
              if (widget.chatFooterData.thirdLayerQuestion != null) ...[
                arrow,
                Text(
                  '3. ${widget.chatFooterData.thirdLayerQuestion!.prompt}',
                  style: questionTextStyle,
                ),
              ],
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 12,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: [
                ...widget.chatFooterData.variants
                    .mapIndexed(
                      (index, question) => Flexible(
                        child: _PromptButton(
                          onPressed: () {
                            if (selectedButtonIndex != index) {
                              setState(() {
                                selectedButtonIndex = index;
                              });
                            }
                            context.read<ChatRoomCubit>().onButtonClick(question);
                          },
                          text: question.prompt,
                          backgroundColor: selectedButtonIndex == index
                              ? AppColors.green
                              : Colors.transparent,
                          textColor: selectedButtonIndex == index
                              ? Colors.white
                              : AppColors.buttonTextColor,
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _PromptButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  const _PromptButton({
    required this.onPressed,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return AppColors.green.withOpacity(0.08);
                }
                return null;
              },
            ),
            backgroundColor: MaterialStatePropertyAll(backgroundColor),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            elevation: const MaterialStatePropertyAll(0),
            shape: const MaterialStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: AppColors.green,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 21 / 14,
            ),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}

EdgeInsetsGeometry paddingFooter(BuildContext context) => EdgeInsets.symmetric(
      horizontal: switch (context.deviceType) {
        LargeDeviceType() => MediaQuery.sizeOf(context).width * 0.2,
        MediumDeviceType() => MediaQuery.sizeOf(context).width * 0.2,
        SmallDeviceType() => 20,
      },
    );
