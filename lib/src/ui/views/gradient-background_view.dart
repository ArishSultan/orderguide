import 'package:flutter/material.dart';
import 'package:orderguide/src/base/theme.dart';

class GradientBackgroundView extends DecoratedBox {
  GradientBackgroundView({Widget child})
      : super(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor.shade400,
                AppTheme.primaryColor.shade900
              ],
            ),
          ),
        );
}
