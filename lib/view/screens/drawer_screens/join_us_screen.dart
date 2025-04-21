import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/color_styles.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({super.key});

  @override
  JoinUsScreenState createState() => JoinUsScreenState();
}

class JoinUsScreenState extends State<JoinUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _contributionController = TextEditingController();

  void _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final String subject = Uri.encodeComponent('Bize Katılın: ${_nameController.text}');
      final String body = Uri.encodeComponent('''
Ad Soyad: ${_nameController.text}
Telefon: ${_phoneController.text}
E-posta: ${_emailController.text}
Meslek: ${_professionController.text}
Yaş: ${_ageController.text}
Cinsiyet: ${_genderController.text}
Katkı Sunacağı Konu: ${_contributionController.text}
''');

      final Uri emailUri = Uri.parse('mailto:hekimane14@gmail.com?subject=$subject&body=$body');

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-posta gönderilemedi')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.appBackGroundColor,
      appBar: AppBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
        title: Text(
          'Bize Katılın',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorStyles.appTextColor, fontSize: 16),
        ),
        leading: const BackButton(color: ColorStyles.appTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, 'Ad Soyad', keyboardType: TextInputType.text),
                _buildTextField(_phoneController, 'Telefon', keyboardType: TextInputType.phone),
                _buildTextField(_emailController, 'E-Posta', keyboardType: TextInputType.emailAddress),
                _buildTextField(_professionController, 'Meslek', keyboardType: TextInputType.text),
                _buildTextField(_ageController, 'Yaş', keyboardType: TextInputType.number),
                _buildTextField(_genderController, 'Cinsiyet', keyboardType: TextInputType.text),
                _buildTextField(_contributionController, 'Katkı Sunacağınız Konu',
                    maxLines: 3, keyboardType: TextInputType.text),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyles.appTextColor,
                    textStyle: const TextStyle(color: ColorStyles.appBackGroundColor),
                  ),
                  onPressed: _sendEmail,
                  child: const Text(
                    'Gönder',
                    style: TextStyle(color: ColorStyles.appBackGroundColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: const TextStyle(color: ColorStyles.appTextColor, fontSize: 14),
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.red.withOpacity(0.7)),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          labelText: label,
          labelStyle: const TextStyle(color: ColorStyles.appTextColor, fontSize: 14),
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label boş bırakılamaz';
          }
          return null;
        },
      ),
    );
  }
}
