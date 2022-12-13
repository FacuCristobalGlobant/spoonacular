import 'package:flutter/material.dart';

class DropDownFilter extends StatelessWidget {
  final String value;
  final String title;
  final List<DropdownMenuItem<String>> validValues;
  final Function(String?) onChanged;

  const DropDownFilter({
    Key? key,
    required this.value,
    required this.title,
    required this.onChanged,
    required this.validValues,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: DropdownButton<String>(
        isExpanded: true,
        value: value,
        items: validValues,
        onChanged: onChanged,
      ),
    );
  }
}
