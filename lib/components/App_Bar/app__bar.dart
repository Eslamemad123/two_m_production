import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:two_m_production/core/constatnts/images.dart';
import 'package:two_m_production/core/utils/textStyles.dart';

class NewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewAppBar({
    super.key,
    this.title = '',
    this.leading = false,
    //this.action = false,
    //this.icon,
    // this.onPress,
  });
  final String title;
  final bool leading;
  //final bool action;
  //final String? icon;
  //void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: AppFontStyles.getSize18(
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),

      centerTitle: true,
      leadingWidth: 75.w,
      leading: leading
          ? Padding(
              padding: EdgeInsets.only(left: 12.r),
              child: //SvgPicture.asset(App_Assets.backArrowSVG)
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(AppAssets.backCircleSVG),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
