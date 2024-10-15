import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/presentation/news/widgets/post_widget.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';

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

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        // controller: scrollController,
        child: CustomScrollView(
          // controller: scrollController,
          slivers: [_sliverAppBar(context), _buildSliverList()],
        ),
      ),
    ),
    // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    floatingActionButton: FloatingActionButton(
      // backgroundColor: Colors.black,
      child: new Icon(Icons.camera),
      onPressed: () {},
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(50.0)),
    ),
  );
  }

  SliverAppBar _sliverAppBar(BuildContext context) {
    return SliverAppBar(
      // shadowColor: AppColors.primary,
      backgroundColor: AppColors.secondBackground,
      // forceMaterialTransparency: true,
      surfaceTintColor: AppColors.primary,
      primary: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          "News",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        background: Container(color: Colors.transparent,),
      ),
      expandedHeight: 110,
      floating: false,
      pinned: true,
      leading: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(width: 5,),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home,
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.chat),
          onPressed: () {
            context.go(Routes.chat);
          },
        ),
        IconButton(
          icon: const Icon(Icons.map),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.account_box),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.emergency, color: Colors.red,),
          onPressed: () {},
        ),
        SizedBox(width: 10,)
      ],
    );
  }

  _buildSliverList() => [SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Card(
              // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                // elevation: 0,
                color: AppColors.background, child: Post());
          },
          childCount: 20,
        ),
      )];
}
