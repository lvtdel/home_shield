import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/domain/chat/entities/group.dart';
import 'package:home_shield/presentation/chat/bloc/contact_cubit.dart';
import 'package:home_shield/presentation/news/widgets/post_widget.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  void initState() {
    context.read<ContactCubit>().loadContact();
    super.initState();
  }

  void _onClickGroup(Group group) {
    context.push(Routes.chat, extra: group);
  }

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
        child:
            BlocBuilder<ContactCubit, ContactState>(builder: (context, state) {
          if (state is ContactSuccess) {
            List<Group> groups = state.groups;

            return ListView.builder(
                itemCount: groups.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    // padding: const EdgeInsets.all(8.0),
                    child: _avatar(groups[index].image, AppSize.s80, context),
                  );
                });
          }

          if (state is ContactError) {
            return Text(state.mess);
          }

          return const SizedBox(
              height: 20,
              width: 20,
              child: Center(child: CircularProgressIndicator()));
        }),
        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal, // Cuộn ngang
        //   child: Row(
        //     children: List.generate(10, (index) {
        //       return Container(
        //         // margin: EdgeInsets.symmetric(horizontal: 2),
        //         // padding: const EdgeInsets.all(8.0),
        //         child: _avatar(AppSize.s80, context),
        //       );
        //     }),
        //   ),
        // ),
      ),
    );
  }

  Container _avatar(String image, double size, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: Theme.of(context).primaryColor)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(shape: AppShapes.circle),
        margin: const EdgeInsets.all(AppPadding.p5),
        height: size,
        width: size,
        child: GestureDetector(
          onTap: () {
            // context.go(Routes.chat);
            context.push(Routes.chat);
          },
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  _contactList() {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        if (state is ContactSuccess) {
          List<Group> groups = state.groups;

          return SliverFixedExtentList(
            itemExtent: 100.0, // Chiều cao của mỗi item
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _onClickGroup(groups[index]);
                  },
                  child: _contactItem(groups[index], context),
                );
              },
              childCount: groups.length, // Số lượng phần tử trong danh sách
            ),
          );
        }

        if (state is ContactError) {
          return SliverToBoxAdapter(child: Text(state.mess));
        }

        return const SliverToBoxAdapter(
            child: Center(
          child: SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(),
          ),
        ));
      },
    );
  }

  _contactItem(Group group, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onClickGroup(group);
      },
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              _avatar(group.image, AppSize.s70, context),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Chiều này có vụ án mới",
                    style: Theme.of(context).textTheme.bodyMedium,
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
