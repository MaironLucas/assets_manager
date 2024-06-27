import 'package:assets_manager/common/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) => AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.onSecondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: context.colorScheme.secondary,
        leading: GoRouter.of(context).canPop()
            ? GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: context.colorScheme.onSecondary,
                ),
                onTap: () => GoRouter.of(context).pop(),
              )
            : null,
      );

  @override
  Size get preferredSize => const Size(double.infinity, 50);
}
