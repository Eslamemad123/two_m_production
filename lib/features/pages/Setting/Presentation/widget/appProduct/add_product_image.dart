import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:two_m_production/components/buttons/main_button.dart';
import 'package:two_m_production/core/extentions/imagePicker.dart';
import 'package:two_m_production/core/utils/colors.dart';
import 'package:two_m_production/core/utils/textStyles.dart';
import 'package:two_m_production/features/pages/Setting/Presentation/cubit/settingCubit.dart';
import 'package:two_m_production/generated/lib/core/localization/locale_keys.g.dart';

class AddProductImage extends StatefulWidget {
  final Color inputFillColor;
  final SettingCubit cubit;

  const AddProductImage({super.key, required this.inputFillColor,required this.cubit});

  @override
  State<AddProductImage> createState() => _AddProductImageState();
}

class _AddProductImageState extends State<AddProductImage> {
  void _pickMedia() async {
    final newMedia = await UploadMultiImages();
    if (newMedia.isNotEmpty) {
      setState(() {
        widget.cubit.selectedMedia.addAll(newMedia);
      });
    }
  }

  void _removeMedia(int index) {
    setState(() {
      widget.cubit.selectedMedia.removeAt(index);
    });
  }

  bool _isVideo(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.avi') ||
        lower.endsWith('.mkv');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.r),
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.inputFillColor,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.border, style: BorderStyle.solid),
        ),
        child: Column(
          children: [
            if (widget.cubit.selectedMedia.isNotEmpty) ...[
              SizedBox(
                height: 100.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.cubit.selectedMedia.length,
                  separatorBuilder: (context, index) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    final media = widget.cubit.selectedMedia[index];
                    final isVideo = _isVideo(media.path);

                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            width: 100.h,
                            height: 100.h,
                            color: AppColors.gray200,
                            child: isVideo
                                ? const Center(
                                    child: Icon(
                                      Icons.videocam,
                                      color: AppColors.primary,
                                      size: 40,
                                    ),
                                  )
                                : Image.file(
                                    File(media.path),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeMedia(index),
                            child: CircleAvatar(
                              radius: 12.r,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.close,
                                size: 16.r,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
            ],
            if (widget.cubit.selectedMedia.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cloud_upload_outlined,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                LocaleKeys.add_product_upload_image.tr(),
                style: AppFontStyles.getSize14(
                  fontColor: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12.r),
            ],
            MainButton(
              buttonText: LocaleKeys.add_product_select_image.tr(),
              onPressed: _pickMedia,
              height: 35.h,
              width: 170.w,
              borderRadius: 10.r,
            ),
          ],
        ),
      ),
    );
  }
}
