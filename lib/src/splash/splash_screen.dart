import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/app_utils/export.dart';

class SpinImageAnimation extends StatefulWidget {
  @override
  _SpinImageAnimationState createState() => _SpinImageAnimationState();
}

class _SpinImageAnimationState extends State<SpinImageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    _controller.repeat(
        reverse: true); // This repeats the animation indefinitely
  }

  checkUserData() {
    Future.delayed(Duration(seconds: 6), () {

          NavigationService.navigateReplacementTo(
              RoutesGenerator.loginRoute);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light
          .copyWith(statusBarColor: AppColors.primaryColor),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                AppColors.primaryColor,
                AppColors.linearGradientColor
              ])),
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001) // Perspective
                    ..rotateY(_controller.value * 3.1415926535897932 * 2.0),
                  alignment: Alignment.center,
                  child: Image.asset(AppImages.appLogoMain,
                      height: 200.0,
                      width:
                          200.0), // Replace 'assets/image.png' with your image path
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
