import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/constant/app_constant.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/data/notification/models/notification_model.dart';
import 'package:home_shield/domain/auth/entites/user.dart';
import 'package:home_shield/presentation/notification/cubit/notif_cubit.dart';
import 'package:home_shield/presentation/widgets/process.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  void initState() {
    context.read<NotifCubit>().getNotif();
    super.initState();
  }

  _onDeleteNotif(String notifId) {
    context.read<NotifCubit>().deleteNotif(notifId);
  }

  _onAcceptNotif(NotificationModel notif) {
    context.read<NotifCubit>().acceptNotif(notif);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldEdit(
      bodySlivers: <Widget>[_list()],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.push(Routes.createGroup);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _list() {
    var userList = [UserApp(name: "Tran Minh Quang", phoneNumber: "0981147346", email: "quangtm.21it@vku.udn.vn", bloodType: "A", image: "https://firebasestorage.googleapis.com/v0/b/home-shield-ce8cb.firebasestorage.app/o/images%2Favatar%2FOIP%20(1).jpg?alt=media&token=8ebbf82c-a537-46e9-ba14-340b312acbd6"),
    UserApp(name: "Vo The Luc", phoneNumber: "0915941872", email: "votheluc0@gmail.com", bloodType: "B", image: "https://firebasestorage.googleapis.com/v0/b/home-shield-ce8cb.firebasestorage.app/o/images%2Favatar%2Fcool-avatar-transparent-image-cool-boy-avatar-11562893383qsirclznyw.png?alt=media&token=80035b30-67d6-4ae6-ae1e-0b2de6a4d025"
    )];
    return SliverFixedExtentList(
    itemExtent: 100.0, // Chiều cao của mỗi item
    delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return _friendItem(context, userList![index]);
        },
        childCount:
        userList.length // Số lượng phần tử trong danh sách
    ),
  );
    // return BlocBuilder<NotifCubit, NotifState>(
    //   builder: (context, state) {
    //     if (state is ShowNotif) {
    //
    //
    //
    //             var notifList = snapshot.data;
    //
    //             if (notifList!.isEmpty) {
    //               return const SliverToBoxAdapter(
    //                 child: SizedBox(
    //                   height: 300,
    //                   child: Center(
    //                     child: Text("Great! Nothing notification here."),
    //                   ),
    //                 ),
    //               );
    //             }
    //
    //             return SliverFixedExtentList(
    //               itemExtent: 140.0, // Chiều cao của mỗi item
    //               delegate: SliverChildBuilderDelegate(
    //                   (BuildContext context, int index) {
    //                 return _notifItem(context, notifList![index]);
    //               },
    //                   childCount:
    //                       notifList?.length // Số lượng phần tử trong danh sách
    //                   ),
    //             );
    //
    //
    //           return const SliverToBoxAdapter(
    //             child: Center(
    //               child: Text("Great! Nothing notification here."),
    //             ),
    //           );
    //         },
    //
    //     }
    //
    //     return SliverToBoxAdapter(
    //       child: processing(),
    //     );
    //   },
    // );
  }

  _friendItem(BuildContext context, UserApp user) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.userDetail, extra: user);
        },
      child:
        Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _avatar(user.image ?? AppConstant.notifImageSample, AppSize.s60,
                    context),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name!,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        // softWrap: true,
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Text("0981 147 346", style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall,)
                    ],
                  ),
                ),
                Icon(Icons.more_horiz, size: 30,),
                SizedBox(width: 18,)
              ],
            ),
          ),
        )
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
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
