import 'package:flutter/material.dart';
import 'package:ilimsehri/view/screens/drawer_screens/about_screen.dart';
import 'package:ilimsehri/view/screens/drawer_screens/join_us_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/color_styles.dart';
import '../../constant/route_constants.dart';
import '../../helper/platform_helper.dart';
import '../../helper/route/icon_helper.dart';
import '../../helper/url_launcher_helper.dart';
import '../../helper/whatsAppHelper.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  Future<String> _getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return "Version ${packageInfo.version}";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorStyles.appBackGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          _buildProfileSection(),
          const SizedBox(height: 10),
          const Divider(color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                _buildDrawerItem(
                    context, Icons.info_outline, "Hakkında", () => _navigateTo(context, const AboutUsPage())),
                _buildDrawerItem(context, Icons.phone, "WhatsApp", _whatsAppOnTap,
                    svgIcon:
                        IconHelper.getSvgIcon(name: 'svg/social_media/whatsapp', size: 23, color: ColorStyles.sepya)),
                _buildDrawerItem(
                    context, Icons.person_add_alt, "Bize Katılın", () => _navigateTo(context, const JoinUsScreen())),
                /*_buildDrawerItem(context, Icons.volunteer_activism, "Katkı Sunanlar",
                    () => _navigateTo(context, OurSupportersScreen())),*/
                const Divider(color: Colors.grey),
                const Spacer(),
                _buildSocialMediaTab(context),
                _buildAppVersion(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 **Profil Bölümü**
  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/img/hekimane.png'),
            ),
          ),
          const Text("hekimane14@gmail.com", style: TextStyle(color: ColorStyles.appTextColor)),
        ],
      ),
    );
  }

  /// 🔹 **Drawer Ögesi**
  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap, {Widget? svgIcon}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      color: ColorStyles.appBackGroundColor.withOpacity(0.6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: ListTile(
        leading: svgIcon ?? Icon(icon, color: ColorStyles.sepya),
        title: Text(title, style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 13)),
        onTap: onTap,
      ),
    );
  }

  /// 🔹 **Sosyal Medya İkonları**
  Widget _buildSocialMediaTab(BuildContext context) {
    final List<Map<String, dynamic>> socialMediaLinks = [
      {'name': 'instagram', 'size': 23, 'host': Routes.instagram, 'path': Routes.instagramAccount},
      {'name': 'x', 'size': 20, 'host': Routes.twitter, 'path': Routes.twitterAccount},
      {'name': 'facebook', 'size': 28, 'host': Routes.facebook, 'path': Routes.facebookAccount},
      {'name': 'youtube', 'size': 28, 'host': Routes.youtube, 'path': Routes.youtubeAccount},
    ];

    return Container(
      padding: const EdgeInsets.only(top: 10),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: socialMediaLinks.map((link) {
              return _buildSocialMediaBox(
                svgIcon: IconHelper.getSvgIcon(
                  name: 'svg/social_media/${link['name']}',
                  size: link['size'].toDouble(),
                  color: ColorStyles.appBackGroundColor,
                  originalColor: true,
                ),
                onPressed: () =>
                    UrlLauncherHelper.openWebsite(host: link['host'], path: link['path'], isExternal: true),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSocialMediaBox({required Widget svgIcon, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40,
          width: 40,
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35)),
            color: ColorStyles.appTextColor,
          ),
          child: Center(child: svgIcon),
        ),
      ),
    );
  }

  /// 🔹 **Uygulama Versiyonu**
  Widget _buildAppVersion() {
    return FutureBuilder<String>(
      future: _getAppVersion(),
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              const Divider(height: 0),
              const SizedBox(height: 10),
              Text(
                snapshot.data ?? "Loading version...",
                style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  /// 🔹 **Sayfa Yönlendirme**
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
  }

  /// 🔹 **WhatsApp Açma**
  Future<void> _whatsAppOnTap() async {
    String contact = '+905523465337';
    String url = Routes.whatsappUrl(contact);

    if (await WhatsAppHelper.isWhatsAppInstalled(url)) {
      await launchUrl(Uri.parse(Routes.whatsappHelpUrl(contact)));
    } else {
      UrlLauncherHelper.openUrl(PlatformHelper.isIos ? Routes.appStoreWhatsappUrl : Routes.playStoreWhatsappUrl);
    }
  }
}
