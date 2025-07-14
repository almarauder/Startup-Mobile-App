import 'package:flutter/material.dart';

class SortByWidget extends StatelessWidget {
  final String currentValue;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const SortByWidget({
    Key? key,
    required this.currentValue,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Сортировать по:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 8),
        DropdownButton<String>(
          value: currentValue,
          underline: SizedBox(), // убираем стандартную линию
          icon: Icon(Icons.arrow_drop_down),
          items: options.map((opt) {
            return DropdownMenuItem(
              value: opt,
              child: Text(
                opt,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
