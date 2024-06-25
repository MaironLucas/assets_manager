import 'package:assets_manager/generated/l10n.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    required this.onSubmitted,
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final void Function(String value) onSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) => Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: TextField(
          style: const TextStyle(
            fontSize: 14,
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: S.of(context).textFieldHint,
            prefixIcon:const  Icon(
              Icons.search,
              size: 16,
            ),
            contentPadding:const  EdgeInsets.symmetric(
              horizontal: 4,
            ),
            enabledBorder:const  OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          onSubmitted: onSubmitted,
        ),
      );
}
