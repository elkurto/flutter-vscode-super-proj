import 'dart:math';
import 'package:flutter/material.dart';


class AppParticleWidget extends StatefulWidget {
  const AppParticleWidget({super.key});

  @override
  State<AppParticleWidget> createState() => _AppParticleWidgetState();
}

class _AppParticleWidgetState extends State<AppParticleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> listParticle =List<Particle>.generate(5, (index){Particle.random(index);};)
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Particle {
  int id;
  double x ;
  double y;
  double vx; // pixel/millis
  double vy; // pixel/millis
  
  static double v0 =0.005;
  Particle(this.id, this.x, this.y, this.vx, this.vy);

  // a factory constructor -- because decent languages use biz logic in ctor
  factory Particle.random({id,x,y}) {
    double theta =Random().nextDouble() * 2*pi;
    return Particle(id,x,y,v0*cos(theta), v0*sin(theta));
  };
}