import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/news/widgets/post_widget.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldEdit(
      bodySlivers: <Widget>[_contactAvatarSliver(context), _contactList()],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  SliverToBoxAdapter _contactAvatarSliver(context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 120, // Chiều cao của thanh cuộn ngang
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, // Cuộn ngang
          child: Row(
            children: List.generate(10, (index) {
              return Container(
                // margin: EdgeInsets.symmetric(horizontal: 2),
                // padding: const EdgeInsets.all(8.0),
                child: _avatar(AppSize.s80, context),
              );
            }),
          ),
        ),
      ),
    );
  }

  Container _avatar(double size, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: Theme.of(context).primaryColor)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(shape: AppShapes.circle),
        margin: const EdgeInsets.all(AppPadding.p5),
        width: size,
        child: GestureDetector(
          onTap: () {
            // context.go(Routes.chat);
            context.push(Routes.chat);
          },
          child: Image.network(
              "https://imgt.taimienphi.vn/cf/Images/tt/2021/8/20/top-anh-dai-dien-dep-chat-56.jpg"),
        ),
      ),
    );
  }

  _contactList() {
    return SliverFixedExtentList(
      itemExtent: 100.0, // Chiều cao của mỗi item
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return _contactItem(index, context);
        },
        childCount: 20, // Số lượng phần tử trong danh sách
      ),
    );
  }

  _contactItem(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("click chat");
        // context.go(Routes.chat);
        context.push(Routes.chat);

      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              _avatar(AppSize.s70, context),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thám tử lừng danh",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "Chiều này có vụ án mới",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
