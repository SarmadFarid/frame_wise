import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frame_wise/app/core/theme/theme_extensions.dart';
import 'package:frame_wise/app/widgets/custom_text.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          _item(context, 0, Icons.home_filled, "Home"),
          _item(context, 1, Icons.add_box_outlined, "Import"),
          _item(context, 2, Icons.calendar_today_outlined, "Project"),
          _item(context, 3, Icons.settings_outlined, "Settings"),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, int index, IconData icon, String label) {
    final bool isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(index == 0 ? 25.r : 0),
              topRight: Radius.circular(index == 3 ? 25.r : 0),
            ),
            color: isSelected
                ? context.colors.brandPrimary.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Top Indicator Line
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                height: 3.h,
                width: isSelected ? 30.w : 0,
                margin: EdgeInsets.only(bottom: 6.h, top: 0),
                decoration: BoxDecoration(
                  color: context.colors.brandPrimary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              Icon(
                icon,
                size: 22.sp,
                color: isSelected
                    ? context.colors.brandPrimary
                    : context.colors.textGrey,
              ),

              SizedBox(height: 4.h),

              CustomText(
                label,
                style: context.themeText.bodySmall?.copyWith(
                  color: isSelected
                      ? context.colors.textPrimary
                      : context.colors.textGrey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
