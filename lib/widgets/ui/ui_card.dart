import 'package:flutter/material.dart';

import '../app_colors.dart';

/// Flutter equivalents for the TSX `Card` component family:
/// - `Card`, `CardHeader`, `CardTitle`, `CardDescription`,
///   `CardAction`, `CardContent`, `CardFooter`.

class UiCard extends StatelessWidget {
  const UiCard({super.key, this.margin, this.padding, this.color, this.borderColor, required this.child});

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor ?? AppColors.gray200),
      ),
      child: child,
    );
  }
}

class UiCardHeader extends StatelessWidget {
  const UiCardHeader({super.key, this.padding, required this.child});
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: child,
    );
  }
}

class UiCardTitle extends StatelessWidget {
  const UiCardTitle({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.gray900),
      child: child,
    );
  }
}

class UiCardDescription extends StatelessWidget {
  const UiCardDescription({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 13, color: AppColors.gray500),
        child: child,
      ),
    );
  }
}

class UiCardAction extends StatelessWidget {
  const UiCardAction({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.topRight, child: child);
  }
}

class UiCardContent extends StatelessWidget {
  const UiCardContent({super.key, this.padding, required this.child});
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: child,
    );
  }
}

class UiCardFooter extends StatelessWidget {
  const UiCardFooter({super.key, this.padding, required this.child});
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: child,
    );
  }
}

