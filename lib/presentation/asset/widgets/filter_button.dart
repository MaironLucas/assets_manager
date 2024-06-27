import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    required this.isEnabled,
    required this.text,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final bool isEnabled;
  final String text;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(
      8,
    ),
    child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isEnabled
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              8,
            ),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isEnabled ? Colors.white : Colors.black,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: isEnabled ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
