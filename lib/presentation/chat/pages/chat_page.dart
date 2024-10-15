import 'package:flutter/material.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: CustomScrollView(
            slivers: [
              _sliverAppBar(context),
              _diver(),
              // _body(context)
            ],
          ),
        ),
      ),
      // floatingActionButton: _floatingActionButton,
    );
  }

  Widget _sliverAppBar(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      sliver: SliverAppBar(
        pinned: true,
        // expandedHeight: 150,
        // collapsedHeight: 150,
        actions: [
          _circleContainer(context, Icons.videocam_rounded),
          const SizedBox(
            width: 20,
          ),
          _circleContainer(context, Icons.call_rounded),
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
              Text("Đang hoạt động",
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
        // bottom: PreferredSize(preferredSize: Size.fromHeight(1),
        //     child: Divider(color: AppColors.blackOpacity,)),
      ),
    );
  }

  Widget _circleContainer(BuildContext context, IconData iconData) {
    return SizedBox(
      width: AppSize.s45,
      height: AppSize.s45,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(iconData, color: AppColors.white, size: 20,),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Text("data");
  }

  _diver() {
    return SliverToBoxAdapter(child: Divider(color: AppColors.blackOpacity, height: 1,));
  }
}
