import 'package:flutter/material.dart';

class SectionSelector extends StatelessWidget {
  final List<String> sections;
  final ValueChanged<String> onSelected;

  const SectionSelector({super.key, required this.sections, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: sections.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (v) => onSelected(v!),
    );
  }
}
