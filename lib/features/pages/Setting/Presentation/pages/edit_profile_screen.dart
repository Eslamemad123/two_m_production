import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/components/inputs/main_text_form_field.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingState.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/widget/editProfile/photo_edit_profile.dart';
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
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            var cubit = context.read<SettingCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Profile Picture
                photoEditProfile(cubit: cubit),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0),
                  child: Text(
                    LocaleKeys.profile_edit_image.tr(),
                    style: AppFontStyles.getSize14(
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.gray400,
                    ),
                  ),
                ),
                Gap(30),
                MainTextFormField(
                  controller: cubit.name,
                  label: LocaleKeys.profile_edit_name.tr(),

                  ispassword: false,
                  colorFill: AppColors.gray100,
                  hint: LocaleKeys.profile_full_name.tr(),
                ),

                // Form Fields
                const SizedBox(height: 40),
                MainButton(
                  buttonText: LocaleKeys.common_edit.tr(),
                  onPressed: () {
                    cubit.editProfile(
                      cubit.name.text,
                      cubit.patImage ?? '',
                      context,
                    );
                  },
                  isLoading: cubit.isLoading,
                ),

                // Save Button
              ],
            );
          },
        ),
      ),
    );
  }
}
