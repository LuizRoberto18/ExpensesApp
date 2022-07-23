import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  AdaptativeButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Theme.of(context).copyWith().colorScheme.primary,
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).copyWith().colorScheme.primary,
              textStyle: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            child: Text(label),
          );
  }
}
