import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/domain/post/entities/post.dart';
import 'package:home_shield/presentation/news/bloc/create_news_cubit.dart';
import 'package:home_shield/presentation/news/bloc/create_news_cubit.dart';
import 'package:home_shield/presentation/news/bloc/news_bloc.dart';
import 'package:home_shield/presentation/news/widgets/input_news_widget.dart';
import 'package:home_shield/presentation/news/widgets/post_widget.dart';
import 'package:home_shield/presentation/widgets/process.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:home_shield/res/assets_res.dart';

class CreateNewsPage extends StatefulWidget {
  const CreateNewsPage({super.key});

  @override
  State<CreateNewsPage> createState() => _CreateNewsPageState();
}

class _CreateNewsPageState extends State<CreateNewsPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    context.read<CreateNewsCubit>().loadCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldEdit(
      bodySlivers: _buildSliverList(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.camera),
      // ),
    );
  }

  _buildSliverList() {
    return [SliverToBoxAdapter(
      child: BlocBuilder<CreateNewsCubit, CreateNewsState>(
        builder: (context, state) {
          if(state is CreateNewsShowData ) {
            return InputNewsWidget(state.userApp, state.image);
          }

          if(state is CreateNewsError) {
            return const Center(child: Text("Error"),);
          }

          if(state is CreateNewsSuccess) {
            showSnackBar(context, "Create news success");
            context.read<NewsBloc>().add(LoadData());

            Timer(const Duration(seconds: 1), (){context.pop();});
          }

          return processing();
        },
      ),
    )
    ];
  }

// _buildSliverList() => [SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (BuildContext context, int index) {
//           return Card(
//             // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
//             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               // elevation: 0,
//               color: AppColors.background, child: Post());
//         },
//         childCount: 20,
//       ),
//     )];
}
