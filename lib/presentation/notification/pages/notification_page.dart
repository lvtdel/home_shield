import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_shield/core/constant/app_constant.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/data/notification/models/notification_model.dart';
import 'package:home_shield/presentation/notification/cubit/notif_cubit.dart';
import 'package:home_shield/presentation/widgets/process.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
    return BlocBuilder<NotifCubit, NotifState>(
      builder: (context, state) {
        if (state is ShowNotif) {
          return StreamBuilder(
            stream: state.notifListStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(child: processing());
              }

              if (snapshot.hasError) {
                print(snapshot.error);
                return const SliverToBoxAdapter(
                    child: Center(
                  child: Text("Error when fetch notificaion"),
                ));
              }

              if (snapshot.hasData) {
                var notifList = snapshot.data;

                if (notifList!.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 300,
                      child: Center(
                        child: Text("Great! Nothing notification here."),
                      ),
                    ),
                  );
                }

                return SliverFixedExtentList(
                  itemExtent: 140.0, // Chiều cao của mỗi item
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return _notifItem(context, notifList![index]);
                  },
                      childCount:
                          notifList?.length // Số lượng phần tử trong danh sách
                      ),
                );
              }

              return const SliverToBoxAdapter(
                child: Center(
                  child: Text("Great! Nothing notification here."),
                ),
              );
            },
          );
        }

        return SliverToBoxAdapter(
          child: processing(),
        );
      },
    );
  }

  _notifItem(BuildContext context, NotificationModel notif) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _avatar(notif.image ?? AppConstant.notifImageSample, AppSize.s60,
                context),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    notif.content,
                    style: Theme.of(context)
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
                  SizedBox(
                    width: double.infinity,
                    // height: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: () {
                                _onAcceptNotif(notif);
                              },
                              child: const Text('Accept'),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                _onDeleteNotif(notif.id!);
                              },
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
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
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
