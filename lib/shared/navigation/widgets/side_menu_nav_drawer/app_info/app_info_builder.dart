import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;
import 'package:testable_web_app/shared/navigation/widgets/side_menu_nav_drawer/app_info/app_info.dart';

Widget getAppInfoTextOrProgressBuilder(
  BuildContext context,
  AsyncSnapshot<PackageInfo> snapshot,
) {
  final bool isDataNullIncomplete = !snapshot.hasData;
  final PackageInfo? data = snapshot.data;

  if (data == null || isDataNullIncomplete) {
    // Should not be so slow as to require this indicator. Static files.
    return const LinearProgressIndicator();
  }

  final PackageInfo packageInfo = data;
  final String appInfoText = getRelevantAppInfoTextFromPackageInfo(
    packageInfo,
  );

  return Text(
    appInfoText,
  );
}
