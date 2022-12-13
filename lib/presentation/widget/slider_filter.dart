import 'package:flutter/material.dart';

class SliderFilter extends StatelessWidget {
  final String title;
  final String trailing;
  final double maxValue;
  final double minValue;
  final double currentValue;
  final Function(double) onChanged;

  const SliderFilter({
    Key? key,
    required this.title,
    required this.trailing,
    required this.maxValue,
    required this.minValue,
    required this.currentValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Text(
        trailing,
      ),
      subtitle: Slider(
        max: maxValue,
        min: minValue,
        value: currentValue,
        onChanged: onChanged,
      ),
    );
  }
}
