import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:two_m_production/core/extentions/show_dialoges.dart';

Future<String?> uploadImageToCloudinary(
  File mediaFile,
  BuildContext context,
) async {
  const cloudName = "dislsl3sa";
  const uploadPreset = "se77ty";

  final url = Uri.parse(
    'https://api.cloudinary.com/v1_1/$cloudName/auto/upload',
  );

  final request = http.MultipartRequest('POST', url);

  request.fields['upload_preset'] = uploadPreset;

  request.files.add(
    await http.MultipartFile.fromPath(
      'file',
      mediaFile.path,
    ),
  );

  try {
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseData = json.decode(responseBody);

      log('Cloudinary response: $responseData');

      return responseData['secure_url'];
    } else {
      showMyDialog(context, 'حدث خطا اثناء رفع الملف');
      return null;
    }
  } catch (e) {
    log(e.toString());
    showMyDialog(context, 'حدث خطا اثناء رفع الملف');
    return null;
  }
}