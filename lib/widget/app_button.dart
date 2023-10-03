import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart'; 
class AppButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onTap;
  final bool disabled;
  final bool shadow;
  final double? width;
  final MainAxisSize size;
  final BoxBorder? border;
  AppButton({
    Key? key,
    required this.text,
    this.onTap,
    this.leading,
    this.border,
    this.shadow = true,
    this.disabled = false,
    this.width,
    this.size = MainAxisSize.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryGreen,
            border: border),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
