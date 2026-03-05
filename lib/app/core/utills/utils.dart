import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../services/logger_service.dart';

class Utils {
  static String formatDate(DateTime? date) =>
      DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

  static String formatDateDMY(DateTime? date) =>
      DateFormat('dd-MM-yyyy').format(date ?? DateTime.now());

  static String? formatDateTime(DateTime? date) {
    if (date == null) return null;
    return DateFormat('MMM d, h:mm a').format(date);
  }

  static bool isNotExpired(String date) {
    try {
      final cleaned = date
          .replaceAll(RegExp(r'\s+'), '')
          .replaceAll(RegExp(r'[./]'), '-')
          .trim();

      final inputDate = DateTime.parse(cleaned);
      final today = DateTime.now();
      final currentDate = DateTime(today.year, today.month, today.day);

      return inputDate.isAfter(currentDate) ||
          inputDate.isAtSameMomentAs(currentDate);
    } catch (e) {
      LoggerService.i('Invalid date format: $date');
      return false;
    }
  }

  static void showBottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(14.sp),
          topLeft: Radius.circular(14.sp),
        ),
      ),
      context: context,
      builder: (_) => SizedBox(
        width: ScreenUtil().screenWidth,
        child: child,
      ),
    );
  }

  static void showCustomDialog({
    required BuildContext context,
    required Widget child,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22.sp),
        ),
        child: child,
      ),
    );
  }

  static Future<void> showPickImageOptionsDialog(
    BuildContext context, {
    required VoidCallback onCameraTap,
    required VoidCallback onGalleryTap,
    VoidCallback? onFileTap,
    bool? hasFile,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: onCameraTap,
            child: const Text('Camera'),
          ),
          CupertinoActionSheetAction(
            onPressed: onGalleryTap,
            child: const Text('Gallery'),
          ),
          if (hasFile == true && onFileTap != null)
            CupertinoActionSheetAction(
              onPressed: onFileTap,
              child: const Text('Pick File (PDF, DOC)'),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
