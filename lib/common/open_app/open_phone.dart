import 'package:flutter/cupertino.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

void callPhone(String phoneNumber, BuildContext context) async {
  var context;
  final Uri url = Uri.parse('tel:$phoneNumber');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    showSnackBar(
        context, 'Không thể mở ứng dụng gọi điện thoại với số $phoneNumber');
    // throw 'Không thể mở ứng dụng gọi điện thoại với số $phoneNumber';
  }
}

