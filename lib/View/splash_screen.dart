import 'dart:async';

import 'package:covid19/packages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () {
        nextScreen(context, const WorldStates());
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              child: Container(
                alignment: Alignment.center,
                child: Image.asset('assets/virus.png'),
              ),
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animationController.value * 2.0 * pi,
                  child: child,
                );
              },
            ),
            SizedBox(
              height: height * 0.1,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Covid 19 Tacker by \n Alpha Coders',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// in this screen we have a logo that rotate app name
// for the logo rotation  we can use animation builder
