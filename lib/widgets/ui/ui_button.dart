import 'package:flutter/material.dart';

import '../app_colors.dart';

/// High-level replacement for the TSX `Button` component with
/// shadcn-like `variant` and `size` options.
class UiButton extends StatelessWidget {
  const UiButton({
    super.key,
    this.variant = UiButtonVariant.defaultVariant,
    this.size = UiButtonSize.defaultSize,
    this.onPressed,
    this.icon,
    required this.child,
  });

  final UiButtonVariant variant;
  final UiButtonSize size;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final (padding, minHeight, iconPadding) = switch (size) {
      UiButtonSize.sm => (const EdgeInsets.symmetric(horizontal: 12, vertical: 6), 32.0, 8.0),
      UiButtonSize.lg => (const EdgeInsets.symmetric(horizontal: 20, vertical: 10), 44.0, 10.0),
      UiButtonSize.icon => (const EdgeInsets.all(8), 36.0, 0.0),
      UiButtonSize.defaultSize => (const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 36.0, 8.0),
    };

    final childContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon!,
          if (size != UiButtonSize.icon) SizedBox(width: iconPadding),
        ],
        if (size != UiButtonSize.icon) Flexible(child: child),
      ],
    );

    return switch (variant) {
      UiButtonVariant.outline => OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: padding,
            minimumSize: Size(minHeight, minHeight),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: const BorderSide(color: AppColors.gray200),
          ),
          child: childContent,
        ),
      UiButtonVariant.secondary => FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: padding,
            minimumSize: Size(minHeight, minHeight),
            backgroundColor: AppColors.gray100,
            foregroundColor: AppColors.gray900,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: childContent,
        ),
      UiButtonVariant.ghost => TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: padding,
            minimumSize: Size(minHeight, minHeight),
            foregroundColor: AppColors.gray700,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: childContent,
        ),
      UiButtonVariant.link => TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: padding,
            minimumSize: Size(minHeight, minHeight),
            foregroundColor: AppColors.blue600,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: childContent,
        ),
      UiButtonVariant.destructive => FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: padding,
            minimumSize: Size(minHeight, minHeight),
            backgroundColor: AppColors.red600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: childContent,
        ),
      UiButtonVariant.defaultVariant => FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: padding,
            minimumSize: Size(minHeight, minHeight),
            backgroundColor: AppColors.blue600,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: childContent,
        ),
    };
  }
}

enum UiButtonVariant {
  defaultVariant,
  destructive,
  outline,
  secondary,
  ghost,
  link,
}

enum UiButtonSize {
  defaultSize,
  sm,
  lg,
  icon,
}

