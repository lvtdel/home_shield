import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_shield/common/emergency/emer_global_bloc.dart';
import 'package:home_shield/common/open_app/open_phone.dart';
import 'package:home_shield/presentation/widgets/snack_bar.dart';
import 'package:sensors_plus/sensors_plus.dart';

class EmerGlobal extends StatefulWidget {
  const EmerGlobal({super.key, required this.child});

  final Widget child;

  @override
  State<EmerGlobal> createState() => _EmerGlobalState();
}

class _EmerGlobalState extends State<EmerGlobal> {
  static const double shakeThreshold = 15.0;
  double _previousX = 0.0, _previousY = 0.0, _previousZ = 0.0;
  DateTime _lastShakeTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      double dx = event.x - _previousX;
      double dy = event.y - _previousY;
      double dz = event.z - _previousZ;

      double shakeMagnitude = sqrt(dx * dx + dy * dy + dz * dz);

      if (shakeMagnitude > shakeThreshold) {
        final now = DateTime.now();
        if (now.difference(_lastShakeTime).inMilliseconds > 500) {
          _lastShakeTime = now;
          onShakeDetected();
        }
      }

      _previousX = event.x;
      _previousY = event.y;
      _previousZ = event.z;
    });
  }

  void onShakeDetected() {
    context.read<EmerGlobalBloc>().add(ShakeDetected());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmerGlobalBloc, EmerGlobalState>(
      listener: (context, state) {
        if (state is SendLocaSuccess || state is SendLocaError) {
          showSnackBar(context, "Send location success");

          // callPhone("0915 941 874", context);
          return;
        }

        if (state is EmerGettingLocation) {
          showSnackBar(context, "Getting location");

        }


      },
      child: widget.child,
    );
  }
}
