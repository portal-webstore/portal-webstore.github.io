import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;

/// Formatted display new lines
///
/// Platform-dependent.
///
/// Conditionally check for platforms that do not have additional package info
///
/// Only display relevant information
String getRelevantAppInfoTextFromPackageInfo(PackageInfo packageInfo) {
  final String appName = packageInfo.appName;
  final String version = packageInfo.version;
  final String buildNumber = packageInfo.buildNumber;
  final String packageName = packageInfo.packageName;

  // Flutter web, apps cross-platform info
  final appNameText = 'App: $appName \n';
  final versionNameText = 'Version: v$version \n';

  // Flutter mobile, maybe desktop has build and package info.
  // Flutter web does not have build or package info
  // Blank out line and new lines entirely if not present.
  final buildNumberText = buildNumber != '' ? 'Build: $buildNumber \n' : '';
  final packageNameText = packageName != '' ? 'Package: $packageName' : '';

  return appNameText + versionNameText + buildNumberText + packageNameText;
}

/// Superfluous wrapper for future adaptation
Future<PackageInfo> getAppNameVersion() {
  final Future<PackageInfo> packageInfo = PackageInfo.fromPlatform();

  return packageInfo;
}
