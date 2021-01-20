import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ConfirmationAction<T> = FutureOr<T> Function();
typedef ConfirmationDialogBuilder = Widget Function(BuildContext);

ConfirmationDialogBuilder defaultDialogBuilder = (context) {
  return AlertDialog(
    title: Text('Are you sure?'),
    actions: [
      TextButton(
        child: Text('Yes'),
        onPressed: () => Navigator.of(context).pop(true),
      ),
      TextButton(onPressed: Navigator.of(context).pop, child: Text('No')),
    ],
  );
};

/// If a custom Dialog is passed here than you must return `true` on the
/// confirmation button for this utility to work correctly.
Future<T> showConfirmation<T>(
  BuildContext context, {
  ConfirmationDialogBuilder builder,
  ConfirmationAction<T> onConfirmed,
  ConfirmationAction<T> onCanceled,
}) async {
  bool result;

  if (builder != null) {
    result = await showDialog(context: context, builder: builder);
  } else if (defaultDialogBuilder != null) {
    result = await showDialog(
      context: context,
      builder: defaultDialogBuilder,
    );
  } else {
    throw 'No Dialog Builder was provided';
  }

  print(result);
  if (result == true) {
    return onConfirmed();
  } else {
    return onCanceled();
  }
}
