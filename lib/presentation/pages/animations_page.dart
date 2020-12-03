import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimateSquare(),
      ),
    );
  }
}

class AnimateSquare extends StatefulWidget {
  AnimateSquare({Key key}) : super(key: key);

  @override
  _AnimateSquare createState() => _AnimateSquare();
}

class _AnimateSquare extends State<AnimateSquare>
    with TickerProviderStateMixin {
  AnimationController animationController;
  AnimationController animationOpacityController;
  Animation<double> rotation;
  Animation<double> curve;
  Animation<double> opacity;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    animationOpacityController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));

    // 2 * pi is a complete rotation
    rotation =
        Tween(begin: 0.0, end: 2.0 * Math.pi).animate(animationController);

    curve = Tween(begin: 0.0, end: 2.0 * Math.pi).animate(
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut));

    opacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationOpacityController,
        curve: Interval(0.0, 1, curve: Curves.bounceOut)));

    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reset();
      }
    });

    animationOpacityController.addListener(() {
      if (animationOpacityController.status == AnimationStatus.completed) {
        animationOpacityController.repeat();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationOpacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.repeat();
    animationOpacityController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Transform.rotate(
                  angle: rotation.value,
                  child: Rectangle(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Transform.rotate(angle: curve.value, child: Rectangle()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Transform.rotate(
                    angle: opacity.value,
                    child: Opacity(
                      opacity: opacity.value,
                      child: Rectangle(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(color: Colors.orange),
    );
  }
}
