import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Setting/widget/editProfile/photo_edit_profile.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: AppFontStyles.getSize18(
            fontWeight: FontWeight.bold,
            fontColor: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            photoEditProfile(),
            const SizedBox(height: 40),
            MainTextFormField(
              ispassword: false,
              colorFill: AppColors.gray100,
              hint: LocaleKeys.profile_edit_profile.tr(),
            ),

            // Form Fields
            const SizedBox(height: 40),
            MainButton(
              buttonText: LocaleKeys.common_edit.tr(),
              onPressed: () {},
            ),

            // Save Button
          ],
        ),
      ),
    );
  }
}
