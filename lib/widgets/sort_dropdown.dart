import 'package:flutter/material.dart';

class SortOption {
  final String value;
  final String displayText;

  const SortOption({required this.value, required this.displayText});

  static const List<SortOption> defaultOptions = [
    SortOption(value: 'most_recent', displayText: 'Most Recent'),
    SortOption(value: 'most_read', displayText: 'Most Read'),
  ];
}

class SortDropdown extends StatefulWidget {
  final String label;
  final List<SortOption> options;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool isLabelAbove;

  const SortDropdown({
    super.key,
    required this.label,
    this.options = SortOption.defaultOptions,
    this.initialValue = 'most_recent',
    required this.onChanged,
    this.isLabelAbove = true,
  });

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.isLabelAbove) ...[
            Text(
              widget.label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedValue,
                isExpanded: true,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                hint: Text(
                  widget.options.firstWhere(
                    (e) => e.value == _selectedValue,
                  ).displayText,
                ),
                items: widget.options.map((option) {
                  return DropdownMenuItem<String>(
                    value: option.value,
                    child: Text(option.displayText),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                    widget.onChanged(newValue);
                  }
                },
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 20,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}