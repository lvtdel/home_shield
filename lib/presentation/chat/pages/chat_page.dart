import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/chat/widgets/circle_item.dart';
import 'package:home_shield/presentation/chat/widgets/text_field_edit.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: _appBar(context),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20,
              vertical: AppPadding.p10,
            ),
            child: CustomScrollView(
              // reverse: true,
              slivers: [
                _sliverAppBar(context),
                _body(context),

              ],
            ),
          ),
        ),
      ),
      bottomSheet: _bottomAppBar(context),
    );
  }

  Widget _bottomAppBar(context) {
    return BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            circleContainer(context, FontAwesomeIcons.camera),
            const SizedBox(
              width: AppSize.s18,
            ),
            const Flexible(
              fit: FlexFit.loose,
              child: SizedBox(height: AppSize.s45, child: TextFieldEdit()),
            )
          ],
        ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      // toolbarHeight: 100,
      actions: [
        circleContainer(context, Icons.videocam_rounded),
        const SizedBox(
          width: 20,
        ),
        circleContainer(context, Icons.call_rounded),
      ],
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://imgt.taimienphi.vn/cf/Images/tt/2021/8/20/top-anh-dai-dien-dep-chat-56.jpg",
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thám tử lừng danh conan",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            "Đang hoạt động",
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(21), // Kích thước của bottom
        child: Divider(
          color: AppColors.blackOpacity,
          height: 1,
        ),
      ),
    );
  }

  Widget _sliverAppBar(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 00),
      sliver: SliverAppBar(
        // floating: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(11), // Kích thước của bottom
          child: Divider(
            color: AppColors.blackOpacity,
            height: 1,
          ),
        ),
        pinned: true,
        backgroundColor: AppColors.background,
        actions: [
          circleContainer(context, Icons.videocam_rounded),
          const SizedBox(
            width: 20,
          ),
          circleContainer(context, Icons.call_rounded),
        ],
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
            "https://imgt.taimienphi.vn/cf/Images/tt/2021/8/20/top-anh-dai-dien-dep-chat-56.jpg",
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thám tử lừng danh conan",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              "Đang hoạt động",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
        // bottom: PreferredSize(preferredSize: Size.fromHeight(1),
        //     child: Divider(color: AppColors.blackOpacity,)),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - 120, // Điều chỉnh chiều cao
        child: ListView.builder(
          reverse: true, // Đảo ngược chiều cuộn
          itemCount: 20, // Thay đổi thành số lượng tin nhắn thực tế
          itemBuilder: (BuildContext context, int index) {
            final isMessageSend = Random.secure().nextBool();

            if (isMessageSend) {
              return _messageSend(context); // Gọi hàm tạo tin nhắn gửi
            } else {
              return _messageReceive(context); // Gọi hàm tạo tin nhắn nhận
            }
          },
        ),
      ),
    );
  }

  Widget _messageSend(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: ShapeDecoration(
            shape: AppShapes.threeRoundedRectangle1,
            color: Theme.of(context).primaryColor,
          ),
          alignment: AlignmentDirectional.center,
          constraints: const BoxConstraints(maxWidth: AppSize.s300),
          child: Text(
            "Chiều này",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _messageReceive(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.all(AppPadding.p16),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: ShapeDecoration(
            shape: AppShapes.threeRoundedRectangle2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          alignment: AlignmentDirectional.center,
          constraints: const BoxConstraints(maxWidth: AppSize.s300),
          child: Text(
            "Chiều này có vụ án mới Chiều nay này có vụ án mới Chiều này có vụ án mới Chiều này có vụ án mới ",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
