import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Header for Chart
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.profits_sales_overview.tr(),
              style: AppFontStyles.getSize18(fontWeight: FontWeight.bold),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  _buildTab(LocaleKeys.profits_weekly_abbr.tr(), true),
                  _buildTab(LocaleKeys.profits_monthly_abbr.tr(), false),
                  _buildTab(LocaleKeys.profits_yearly_abbr.tr(), false),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),

        // Chart container
        SizedBox(
          height: 220.h,
          width: double.infinity,
          child: CustomPaint(painter: SalesChartPainter()),
        ),
      ],
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.white : AppColors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
                  blurRadius: 4.r,
                ),
              ]
            : [],
      ),
      child: Text(
        text,
        style: AppFontStyles.getSize12(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontColor: isSelected
              ? AppColors.textPrimary
              : AppColors.textSecondary,
        ),
      ),
    );
  }
}

class SalesChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    const paddingBottom = 20.0;
    const paddingLeft = 30.0;

    final paintLine = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintDot = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    final paintDotBorder = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    //  final paintGrid = Paint()
    //    ..color = AppColors.borderLight
    //   ..strokeWidth = 1;

    // Grid lines & Y-Axis Labels
    final yLabels = [
      '\$1k',
      '\$1.5k',
      '\$2k',
      '\$2.5k',
      '\$3k',
      '\$3.5k',
      '\$4k',
    ];
    for (int i = 0; i < yLabels.length; i++) {
      final y =
          h - paddingBottom - (i * (h - paddingBottom) / (yLabels.length - 1));
      // Draw grid line
      // canvas.drawLine(Offset(paddingLeft, y), Offset(w, y), paintGrid); // Optional: if design has full grid

      // Draw labels
      final textSpan = TextSpan(
        text: yLabels[i],
        style: TextStyle(
          color: AppColors.textSecondary.withOpacity(0.5),
          fontSize: 10,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    // X-Axis Labels
    final xLabels = [
      LocaleKeys.common_mon.tr(),
      LocaleKeys.common_tue.tr(),
      LocaleKeys.common_wed.tr(),
      LocaleKeys.common_thu.tr(),
      LocaleKeys.common_fri.tr(),
      LocaleKeys.common_sat.tr(),
      LocaleKeys.common_sun.tr(),
    ];

    // Data Points (normalized 0.0 to 1.0) simulating the curve in image
    // Mon: low, Tue: mid-high, Wed: dip, Thu: high, Fri: slight dip, Sat: higher, Sun: peak
    final data = [0.1, 0.4, 0.3, 0.6, 0.5, 0.75, 1.0];

    final path = Path();
    final stepX = (w - paddingLeft) / (data.length - 1);

    // Gradient fill setup
    final pathScan = Path();

    List<Offset> points = [];

    for (int i = 0; i < data.length; i++) {
      final x = paddingLeft + (i * stepX);
      final y = (h - paddingBottom) - (data[i] * (h - paddingBottom));
      points.add(Offset(x, y));

      // Draw X Label
      final textSpan = TextSpan(
        text: xLabels[i],
        style: TextStyle(
          color: AppColors.textSecondary.withOpacity(0.5),
          fontSize: 10,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: ui.TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, h - 10));
    }

    // Move to first point
    path.moveTo(points[0].dx, points[0].dy);
    pathScan.moveTo(points[0].dx, points[0].dy);

    // Quadratic Bezier interpolation for smooth curve
    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      // final controlPoint = Offset(
      //   (p1.dx + p2.dx) / 2,
      //    (p1.dy + p2.dy) /
      //        2, // Simple midpoint for control, or could use advanced spline
      //  );

      // Using catmull-rom or simple cubic usually looks better, but simple line + rounded corners is easiest "smooth" look.
      // Actually for the "wave" look, QuadraticBezierTo halfway is standard.
      // Let's use simple lineTo for now or quadratic if needed. The image shows smooth curves.
      // A simple smoothing technique: use control points based on neighbors.

      // Approximation:
      final cp1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
      final cp2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
      path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
    }

    // Draw Shadow/Gradient fill
    final pathFill = Path.from(path);
    pathFill.lineTo(points.last.dx, h - paddingBottom);
    pathFill.lineTo(points.first.dx, h - paddingBottom);
    pathFill.close();

    final gradient = LinearGradient(
      colors: [
        AppColors.primary.withOpacity(0.2),
        AppColors.primary.withOpacity(0.0),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    canvas.drawPath(
      pathFill,
      Paint()..shader = gradient.createShader(Rect.fromLTWH(0, 0, w, h)),
    );

    // Draw Line
    canvas.drawPath(path, paintLine);

    // Draw Dots
    for (var p in points) {
      canvas.drawCircle(p, 4, paintDot);
      canvas.drawCircle(p, 4, paintDotBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
