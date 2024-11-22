import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/core/routing/route_path.dart';
import 'package:home_shield/core/styles/app_colors.dart';
import 'package:home_shield/core/styles/app_shapes.dart';
import 'package:home_shield/core/styles/app_text_style.dart';
import 'package:home_shield/core/styles/app_values.dart';
import 'package:home_shield/presentation/emergency/cubit/emergency_cubit.dart';
import 'package:home_shield/presentation/widgets/scaffold_edit.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({super.key});

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  @override
  initState() {
    super.initState();
    _sendLocation();
  }

  _sendLocation() async {
    context.read<EmergencyCubit>().sendLocation();
    showSnackBar(context, "Getting location!");
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldEdit(bodySlivers: [_body()]);
  }

  _body() {
    return BlocListener<EmergencyCubit, EmergencyState>(
      listener: (context, state) {
        if (state is SendLocationSuccess) {
          showSnackBar(context, "Send location success");
        }
      },
      child: SliverToBoxAdapter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _item(icon: Icons.location_on_outlined, text: "Map", onTap: (){context.push(Routes.map);}),
                _item(
                    icon: Icons.report_outlined,
                    text: "Report",
                    color: Colors.red.shade600)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _item(icon: Icons.chat_outlined, text: "Messages", onTap: (){context.push(Routes.contact);}),
                _item(icon: Icons.mic_none_outlined, text: "Record")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _item(icon: Icons.gavel_outlined, text: "Info"),
                _item(icon: Icons.quick_contacts_dialer_outlined, text: "Friends", onTap: (){context.push(Routes.friends);}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _item({required IconData icon, required String text, Color? color, onTap}) {
    return Container(
      margin: const EdgeInsets.all(AppPadding.p15),
      decoration: AppShapes.inputBoxDecoration,

      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppSize.s130,
          height: AppSize.s130,
          // decoration: AppShapes.inputBoxDecoration,
          margin: const EdgeInsets.all(3),
          // decoration: AppShapes.inputBoxDecoration,
          decoration: AppShapes.inputBoxDecoration.copyWith(
              color: color ?? AppColors.primary),
          // decoration: ,
          // color: AppColors.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: AppSize.s40,
                color: AppColors.white,
              ),
              const SizedBox(height: 5,),
              Text(text,
                  style: AppTextStyle.bold20.copyWith(color: AppColors.white))
            ],
          ),
        ),
      ),
    );
  }
}
