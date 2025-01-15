import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const DropdownField({
    Key? key,
    required this.label,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
