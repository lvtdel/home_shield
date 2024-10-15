import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_values.dart';

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        children: <Widget>[
          _headerPost(context),
          _content(context),
          _image(),
          _commentPost(context),
        ],
      ),
    );
  }

  _content(context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
        // style: TextStyle(fontFamily: "Poppins-regular", fontWeight: FontWeight.w400, fontSize: 16),
        textAlign: TextAlign.start,
      ),
    );
  }

  Padding _footerPost({Color iconColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _iconButton(
                  icon: FontAwesomeIcons.heart, iconColor: Colors.white),
              const SizedBox(width: 16.0),
              _iconButton(
                  icon: FontAwesomeIcons.comment, iconColor: Colors.white),
              const SizedBox(width: 16.0),
              _iconButton(
                  icon: FontAwesomeIcons.paperPlane, iconColor: Colors.white),
            ],
          ),
          _iconButton(icon: FontAwesomeIcons.bookmark, iconColor: Colors.white),
        ],
      ),
    );
  }

  IconButton _iconButton(
      {Color iconColor = Colors.white, required IconData icon, onPressed}) {
    return IconButton(
      icon: Icon(
        icon,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }

  Widget _image() {
    return Container(
      decoration: ShapeDecoration(shape: AppShapes.roundedRectangle30),
      clipBehavior: Clip.antiAlias,
      child: Stack(children: [
        Image.network(
          "https://th.bing.com/th/id/OIP.4XB8NF1awQyApnQDDmBmQwHaEo?rs=1&pid=ImgDetMain",
          fit: BoxFit.cover,
          height: 300,
          // width: 300,
        ),
        Positioned(
            bottom: -1,
            left: 0,
            right: 0,
            // top: 50,
            child: SizedBox(
              height: 50,
              child: ClipRect(
                // clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 8.0,
                    sigmaY: 8.0,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ),
            )),
        Positioned(bottom: 0, left: 0, right: 0, child: _footerPost()),
      ]),
    );
  }

  Padding _headerPost(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://pbs.twimg.com/profile_images/877903823133704194/Mqp1PXU8_400x400.jpg"))),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "The Verge",
                  // style: TextStyle(fontWeight: FontWeight.bold),
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ]),
    );
  }

  final String text =
      "Phong cảnh thiên nhiên là vẻ đẹp kỳ diệu của tạo hóa, từ núi đồi hùng vĩ đến cánh đồng mênh mông. Ánh bình minh xuyên qua sương mù, tạo nên khung cảnh bình yên, thơ mộng, làm say lòng người.";

  Widget _commentPost(context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            "https://pbs.twimg.com/profile_images/877903823133704194/Mqp1PXU8_400x400.jpg"))),
              ),
              const SizedBox(width: 10.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "The Verge",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.start,
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
