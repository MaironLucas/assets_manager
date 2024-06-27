import 'package:assets_manager/common/util.dart';
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
  Widget build(BuildContext context) => TextField(
    controller: controller,
    focusNode: focusNode,
    style: context.textTheme.bodyMedium,
    decoration: InputDecoration(
      isDense: true,
      fillColor: Colors.grey.withOpacity(0.1),
      filled: true,
      prefixIcon: Icon(
        Icons.search,
        color: Colors.grey.withOpacity(0.4),
      ),
      hintText: S.of(context).textFieldHint,
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: context.colorScheme.primary,
        ),
        borderRadius:const  BorderRadius.all(Radius.circular(4.0)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
    onSubmitted: onSubmitted,
  );
}
