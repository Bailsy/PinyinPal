import'package:flutter/material.dart';
import 'package:newton_particles/newton_particles.dart';

class ExperiencePoints extends StatelessWidget{

  final int totaltime;

  const ExperiencePoints({required this.totaltime, Key? key})
      : super(key: key);


  @override
  Widget build(BuildContext context){
    return Newton(
    activeEffects: [
            RainEffect(
                particleConfiguration: ParticleConfiguration(
                    shape: CircleShape(),
                    size: const Size(10, 10),
                    color: const SingleParticleColor(color: Color.fromARGB(255, 215, 175, 29)),
                ),
                effectConfiguration:  EffectConfiguration(emitDuration: 100
          
                )
            )
    ],
  );
  }
}