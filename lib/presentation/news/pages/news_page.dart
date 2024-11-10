import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/domain/post/entities/post.dart';
import 'package:home_shield/presentation/news/bloc/news_bloc.dart';
import 'package:home_shield/presentation/news/widgets/post_widget.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';
import 'package:home_shield/res/assets_res.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    context.read<NewsBloc>().add(LoadData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldEdit(
      bodySlivers: _buildSliverList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.camera),
      ),
    );
  }

  _buildSliverList() {
    return [
      BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is NewsShowData) {
            List<Post> posts = state.posts;

            if (posts.isEmpty) {
              return SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Image.asset(AssetsRes.FRIEND, height: 200,),
                      Text("Welcome to Home Shield app, add friends to share moments.",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  )),);
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    color: AppColors.background,
                    child: PostElement(
                        posts[index]), // Truyền bài viết vào widget Post
                  );
                },
                childCount: posts.length, // Số lượng bài viết
              ),
            );
          }

          if (state is NewsError) {
            // Hiển thị thông báo lỗi
            return SliverFillRemaining(
              child: Center(child: Text(state.mess)),
            );
          }

          return const SliverFillRemaining(
            child: Center(child: Text('Chưa có bài viết')),
          );
        },
      ),
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
