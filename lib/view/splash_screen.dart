import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mdabali_report/bloc/init_bloc/bloc/init_bloc.dart';
import 'package:mdabali_report/resources/images_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<InitBloc>().add(FetchInitData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitBloc, InitState>(
      listener: (context, state) {
        if (state is InitLoaded) {
          Timer(const Duration(seconds: 2), () => Get.offNamed('/dashboard'));
        }
        if (state is InitFailure) {
          Timer(const Duration(seconds: 2), () => Get.offNamed('/login'));
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: DecoratedBox(
            decoration: const BoxDecoration(),
            child: Image.asset(
              ImagesConstants.mdabaliLogo,
              height: 100,
              width: 100,
            ),
          ),
        ),
      ),
    );
  }
}
