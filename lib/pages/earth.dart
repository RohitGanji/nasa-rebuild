import 'package:flutter/material.dart';
import 'package:model_viewer/model_viewer.dart';

class Earth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModelViewer(
        src: 'assets/3d/Earth.glb',
        alt: "A 3D model of an astronaut",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}
