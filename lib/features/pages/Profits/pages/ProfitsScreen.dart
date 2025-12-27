import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/App_Bar/app__bar.dart';
import 'package:two_m_production/features/pages/Profits/widget/profit_summary_card.dart';
import 'package:two_m_production/features/pages/Profits/widget/profits_items.dart';
import 'package:two_m_production/features/pages/Profits/widget/sales_chart.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class ProfitsScreen extends StatelessWidget {
  const ProfitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if we are in dark mode for manual overrides if needed

    return Scaffold(
      appBar: NewAppBar(title: LocaleKeys.profile_store_manager.tr()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProfitSummaryCard(),
                SizedBox(height: 24.h),

                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: const SalesChart(),
                ),
                SizedBox(height: 24.h),
                ProfitsItems(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
