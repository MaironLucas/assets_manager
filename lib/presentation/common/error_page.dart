import 'package:assets_manager/common/util.dart';
import 'package:assets_manager/data/exceptions.dart';
import 'package:assets_manager/generated/l10n.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    required this.exception,
    required this.onRetry,
    super.key,
  });

  final MyException exception;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          switch(exception) {
            NetworkException() => S.of(context).errorConnectionMessage,
            GenericException() => S.of(context).errorGenericMessage,
          },
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: GestureDetector(
            onTap: onRetry,
            child: Text(
              S.of(context).errorTryAgainButton,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          )
        ),
      ],
    ),
  );
}
