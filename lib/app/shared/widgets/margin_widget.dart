import 'package:flutter/material.dart';

class MarginWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const MarginWidget({Key? key, this.height = 0.0, this.width = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
