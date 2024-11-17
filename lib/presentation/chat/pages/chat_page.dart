import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/constant/app_constant.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/domain/chat/entities/message.dart';
import 'package:home_shield/presentation/chat/bloc/chat_cubit.dart';
import 'package:home_shield/presentation/chat/widgets/circle_item.dart';
import 'package:home_shield/presentation/chat/widgets/text_field_edit.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.group});

  final Group group;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    context.read<ChatCubit>().loadStreamMess(widget.group.id!);
    super.initState();
  }

  Future<bool> _onSend(String content) async {
    Message message = Message(content: content, createdAt: Timestamp.now());
    String groupId = widget.group.id!;

    return context.read<ChatCubit>().sendMess(message, groupId);
  }

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
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                  child: TextFieldEdit(
                onSend: _onSend,
              )),
            )
          ],
        ));
  }

  Widget _sliverAppBar(BuildContext context) {
    return SliverAppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(11),
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
        circleContainer(context, Icons.call_rounded, onTap: () {
          context.push(Routes.call);
        }),
      ],
      leading: CircleAvatar(
        backgroundColor: AppColors.white,
        backgroundImage: NetworkImage(
          widget.group.image,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.group.name,
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
    );
  }

  Widget _body(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            140,
        // Điều chỉnh chiều cao
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            if (state is ChatSuccess) {
              return StreamBuilder<List<Message>>(
                  stream: state.streamMessList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }

                    if (snapshot.hasData) {
                      List<Message> messages = snapshot.data ?? List.empty();

                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          final isMessageSend = messages[index].userApp!.id ==
                              FirebaseAuth.instance.currentUser!.uid;

                          if (isMessageSend) {
                            return _messageSend(messages[index].content,
                                context); // Gọi hàm tạo tin nhắn gửi
                          } else {
                            return _messageReceive(messages[index],
                                context); // Gọi hàm tạo tin nhắn nhận
                          }
                        },
                      );
                    }

                    return const Text("Nothing data to here");
                  });
            }

            if (state is ChatError) {
              return Text("Error: ${state.mess}");
            }

            return const SizedBox(
              width: 20,
              height: 20,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _messageSend(String mess, BuildContext context) {
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
            mess,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _messageReceive(Message mess, BuildContext context) {
    String image = mess.userApp?.image ?? AppConstant.avatarSmample;
    String name = mess.userApp!.name!.split(" ").last;
    String content = mess.content;

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: IntrinsicWidth(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(name, style: TextStyle(fontSize: 14),),
                SizedBox(height: 3,),
                CircleAvatar(
                    backgroundColor: AppColors.white,
                    backgroundImage: NetworkImage(
                      image,
                    )),
              ],
            ),
            const SizedBox(width: 10,),
            Flexible(
              fit: FlexFit.loose,
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
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
