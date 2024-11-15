import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_shield/core/routing/app_router.dart';
import 'package:home_shield/presentation/emergency/cubit/emergency_cubit.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return BlocBuilder<EmergencyCubit, EmergencyState>(
      builder: (context, state) {
        if (state is SendLocationError) {
          showSnackBar(context, "Cannot get location! Try again later.");

          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Send locaion error"),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _sendLocation, child: Text("Try again"))
              ],
            ),
          );
        }

        if (state is SendLocationSuccess) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Send locaion success"),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Go back"))
              ],
            ),
          );
        }

        return const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
