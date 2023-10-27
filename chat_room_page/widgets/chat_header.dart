import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portageur_test/presentation/utils/app_colors.dart';
import 'package:portageur_test/presentation/utils/app_images.dart';
import 'package:portageur_test/presentation/utils/screen_utils.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    this.onSearch,
  });

  final ValueChanged<String>? onSearch;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Responsive(
      small: (_) => _contentWithDimensions(
        context: context,
        inputTextSize: 16,
        heightHeader: size.height * 0.34,
        titleSize: 25,
        inputSize: Size(size.width * 0.8, 40),
        titlePadding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      ),
      medium: (_) => _contentWithDimensions(
        inputTextSize: 18,
        context: context,
        heightHeader:
            size.height >= size.width ? size.height * 0.16 : size.height * 0.3,
        titleSize: 25,
        inputSize: Size(size.width * 0.65, 40),
      ),
      large: (_) => _contentWithDimensions(
        context: context,
        heightHeader: size.height * 0.2,
        titleSize: 30,
        inputSize: Size(size.width * 0.4, 40),
      ),
    );
  }

  Widget _contentWithDimensions({
    required BuildContext context,
    required double heightHeader,
    required double titleSize,
    required Size inputSize,
    EdgeInsetsGeometry? titlePadding,
    double inputTextSize = 20,
  }) =>
      Container(
        height: heightHeader,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              AppImages.backgroundImage,
            ),
          ),
        ),
        child: Center(
          child: _ChatHeaderContent(
            onSearch: onSearch,
            titleSize: titleSize,
            inputSize: inputSize,
            titlePadding: titlePadding,
            inputTextSize: inputTextSize,
          ),
        ),
      );
}

class _ChatHeaderContent extends StatelessWidget {
  const _ChatHeaderContent({
    required this.titleSize,
    this.onSearch,
    this.titlePadding,
    required this.inputSize,
    this.inputTextSize = 22,
  });

  final double titleSize;
  final EdgeInsetsGeometry? titlePadding;
  final Size inputSize;
  final double inputTextSize;
  final ValueChanged<String>? onSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: titlePadding ?? const EdgeInsets.only(),
          child: Text(
            'What company are you looking for?',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.w700,
              height: 45 / 30,
            ),
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: inputSize.width,
          height: inputSize.height,
          child: TextField(
            onChanged: onSearch,
            cursorColor: AppColors.mainTextColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 9,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
            ),
            style: GoogleFonts.poppins(
              color: AppColors.mainTextColor,
              fontSize: inputTextSize,
              fontWeight: FontWeight.w500,
              height: 31.5 / 21,
            ),
          ),
        ),
      ],
    );
  }
}
