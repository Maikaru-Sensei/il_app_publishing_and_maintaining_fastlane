import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particles_flutter/engine.dart';
import 'package:particles_flutter/interactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Computing',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<Particle> _buildParticles() {
    final rng = Random();
    double sign() => rng.nextBool() ? 1 : -1;

    return List.generate(120, (_) {
      return CircularParticle(
        color: Colors.white.withValues(alpha: 0.55),
        radius: rng.nextDouble() * 3 + 1,
        velocity: Offset(
          rng.nextDouble() * 40 * sign(),
          rng.nextDouble() * 40 * sign(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          toolbarHeight: 80,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Workshops',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
              Text(
                'App Publishing and Maintaining',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Particles(
            particles: _buildParticles(),
            height: size.height,
            width: size.width,
            connectDots: true,
            boundType: BoundType.WrapAround,
            interaction: ParticleInteraction(
              awayRadius: 120,
              onTapAnimation: true,
              awayAnimationDuration: const Duration(milliseconds: 400),
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: true,
              hoverRadius: 80,
            ),
          ),
          const Center(
            child: IgnorePointer(
              child: Text(
                'We \u2764 MC',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 24, color: Colors.white54)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
