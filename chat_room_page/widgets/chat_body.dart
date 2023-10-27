import 'package:flutter/material.dart';
import 'package:portageur_test/presentation/pages/chat_room_page/widgets/chat_items.dart';
import 'package:portageur_test/presentation/utils/screen_utils.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required List<ChatItem> items,
  }) : _items = items;

  final List<ChatItem> _items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: paddingChat(context),
      itemCount: _items.length,
      itemBuilder: (_, index) => switch (_items[index]) {
        BotChatItem _ => Container(
            alignment: Alignment.centerLeft,
            child: _items[index],
          ),
        UserChatItem _ => Container(
            alignment: Alignment.centerRight,
            child: _items[index],
          ),
      },
      separatorBuilder: (_, __) => const SizedBox(height: 32),
    );
  }
}

EdgeInsetsGeometry paddingChat(BuildContext context) => EdgeInsets.fromLTRB(
    switch (context.deviceType) {
      LargeDeviceType() => MediaQuery.sizeOf(context).width * 0.2,
      MediumDeviceType() => MediaQuery.sizeOf(context).width * 0.2,
      SmallDeviceType() => 20,
    },
    switch (context.deviceType) {
      LargeDeviceType() => 120,
      MediumDeviceType() => 60,
      SmallDeviceType() => 40,
    },
    switch (context.deviceType) {
      LargeDeviceType() => MediaQuery.sizeOf(context).width * 0.2,
      MediumDeviceType() => MediaQuery.sizeOf(context).width * 0.2,
      SmallDeviceType() => 20,
    },
    switch (context.deviceType) {
      LargeDeviceType() => 60,
      MediumDeviceType() => 30,
      SmallDeviceType() => 20,
    });
