import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class GradientHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final bool isDriver;
  final List<Widget>? actions;

  const GradientHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.isDriver,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(gradient: AppColors.getGradient(isDriver)),
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (leading != null) leading!,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: (textTheme.headlineSmall ?? const TextStyle())
                            .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            subtitle!,
                            style: (textTheme.bodyMedium ?? const TextStyle())
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                    ],
                  ),
                ),
                if (actions != null) ...actions!,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
