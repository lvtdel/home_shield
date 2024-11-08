import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/presentation/news/widgets/post_widget.dart';

class ScaffoldEdit extends StatelessWidget {
  const ScaffoldEdit(
      {super.key,
      required List<Widget> bodySlivers,
      required floatingActionButton})
      : _slivers = bodySlivers,
        _floatingActionButton = floatingActionButton;

  final List<Widget> _slivers;
  final FloatingActionButton _floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          // controller: scrollController,
          child: CustomScrollView(
            // controller: scrollController,
            slivers: [_sliverAppBar(context), ..._slivers],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingActionButton,
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
        background: Container(
          color: Colors.transparent,
        ),
      ),
      expandedHeight: 110,
      floating: false,
      pinned: true,
      leading: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {
              context.go(Routes.news);
            },
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
            context.go(Routes.contact);
          },
        ),
        IconButton(
          icon: const Icon(Icons.map),
          onPressed: () {context.push(Routes.map);},
        ),
        IconButton(
          icon: const Icon(Icons.account_box),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.emergency,
            color: Colors.red,
          ),
          onPressed: () {},
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

// _buildList() =>
//     SliverList(
//       delegate: SliverChildBuilderDelegate(
//             (BuildContext context, int index) {
//           return Card(
//             // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
//               margin: const EdgeInsets.symmetric(
//                   vertical: 10, horizontal: 10),
//               // elevation: 0,
//               color: AppColors.background, child: Post());
//         },
//         childCount: 20,
//       ),
//     );
}
