import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/color_styles.dart';
import '../../../helper/text_helper.dart';

class TefsirDetailScreen extends StatefulWidget {
  final String title;
  final String tefsirPdfLink;
  final int index;

  const TefsirDetailScreen({super.key, required this.index, required this.tefsirPdfLink, required this.title});

  @override
  TefsirDetailScreenState createState() => TefsirDetailScreenState();
}

class TefsirDetailScreenState extends State<TefsirDetailScreen> {
  String? localFilePath;
  bool isDownloading = false;
  PDFViewController? _pdfViewController;
  bool _isSearching = false;
  int enteredPage = 0;
  int? savedPage;
  final TextEditingController _controller = TextEditingController();
  TextEditingController editingController = TextEditingController();

  late SharedPreferences _prefs;
  int _savedPdfPageOffset = 0;

  @override
  void initState() {
    super.initState();
    _checkLocalFile();
  }

  Future<void> _checkLocalFile() async {
    final dir = await getApplicationDocumentsDirectory();
    _prefs = await SharedPreferences.getInstance();

    final filePath = '${dir.path}/${widget.title}-${widget.index.toString()}downloaded.pdf';
    final file = File(filePath);
    if (await file.exists()) {
      setState(() => localFilePath = filePath);
      await _loadScrollPosition();
    }
  }

  Future<void> _downloadPdf() async {
    setState(() => isDownloading = true);
    try {
      //final response = await http.get(Uri.parse('https://hekimane.com/wp-content/uploads/2025/03/tefsir.pdf'));
      final response = await http.get(Uri.parse(widget.tefsirPdfLink));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final filePath = '${dir.path}/${widget.title}-${widget.index.toString()}downloaded.pdf';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          localFilePath = filePath;
          isDownloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PDF başarıyla indirildi.')),
        );
      } else {
        throw Exception('PDF indirilemedi!');
      }
    } catch (e) {
      setState(() => isDownloading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF indirilemedi. Hata: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorStyles.appBackGroundColor,
        title: Text(
          TextHelper.capitalizeWords(widget.title),
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16,
                color: ColorStyles.appTextColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: const BackButton(color: ColorStyles.appTextColor),
        actions: [
          if (localFilePath == null && !isDownloading)
            IconButton(
              icon: const Icon(
                Icons.download,
                color: ColorStyles.appTextColor,
              ),
              onPressed: _downloadPdf,
            ),
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: ColorStyles.appTextColor,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _controller.clear();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(
              _savedPdfPageOffset == 0 ? Icons.bookmark_add_outlined : Icons.bookmark,
              color: ColorStyles.appTextColor,
            ),
            onPressed: _changeBookMarkStatus,
          ),
        ],
      ),
      body: localFilePath == null
          ? Center(
              child: isDownloading
                  ? const CircularProgressIndicator()
                  : const Text('Görüntülemek için lütfen dosyayı indiriniz.'),
            )
          : Stack(
              children: [
                Center(
                  child: Transform.scale(
                    scale: 1.2,
                    child: PDFView(
                      defaultPage: savedPage ?? 0,
                      filePath: localFilePath,
                      nightMode: true,
                      pageFling: false,
                      pageSnap: false,
                      onViewCreated: (controller) {
                        _pdfViewController = controller;
                      },
                      onPageChanged: (int? page, int? total) {
                        setState(() {
                          _isSearching = false;
                          _controller.clear();
                        });
                        print('Mevcut Sayfa: $page / Toplam: $total');
                      },
                    ),
                  ),
                ),
                if (_isSearching)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                    child: TextField(
                      controller: _controller,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      autofocus: true,
                      style: const TextStyle(color: ColorStyles.appBackGroundColor),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: ColorStyles.appBackGroundColor, fontSize: 14),
                        labelStyle: TextStyle(color: ColorStyles.appBackGroundColor, fontSize: 14),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorStyles.appBackGroundColor),
                            borderRadius: BorderRadius.all(Radius.circular(25.0))),
                        hintText: "Sayfa Numarası",
                        labelText: "Sayfa Numarası",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorStyles.appBackGroundColor),
                            borderRadius: BorderRadius.all(Radius.circular(25.0))),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorStyles.appBackGroundColor,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorStyles.appBackGroundColor),
                            borderRadius: BorderRadius.all(Radius.circular(25.0))),
                      ),
                      onSubmitted: (value) async {
                        setState(() {
                          _isSearching = false;
                          _controller.clear();
                        });
                        if (value.isEmpty) return;
                        int totalPages = await _pdfViewController?.getPageCount() ?? 0;
                        int page = int.tryParse(value) ?? 1;
                        if (page < 1 || page > totalPages) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Center(
                              child:
                                  Text('Geçersiz sayfa numarası!', style: TextStyle(color: ColorStyles.appTextColor)),
                            )),
                          );
                          return;
                        }
                        _pdfViewController?.setPage(page - 1);
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  Future<void> _loadScrollPosition() async {
    _savedPdfPageOffset = _prefs.getInt('el_mizan_cilt${widget.index}_scrollOffset') ?? 0;
    if (_savedPdfPageOffset != 0) {
      print('Yer imi sayfa numarası: $_savedPdfPageOffset');
      //_pdfViewController?.setPage(_savedPdfPageOffset);
      setState(() {
        savedPage = _savedPdfPageOffset;
      });
    }
  }

  Future<void> _changeBookMarkStatus() async {
    int currentPage = await _pdfViewController?.getCurrentPage() ?? 0;
    setState(() {
      _savedPdfPageOffset = _savedPdfPageOffset == 0 ? currentPage : 0;
    });
    await _prefs.setInt('el_mizan_cilt${widget.index}_scrollOffset', _savedPdfPageOffset);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Köşeleri yumuşat
        ),
        content: Center(
          child: Text(
            _savedPdfPageOffset != 0
                ? "Yer iminiz kaydedildi. Dilediğiniz zaman kaldığınız yerden okumaya devam edebilirsiniz"
                : "Yer imi kaldırıldı",
            style: const TextStyle(color: ColorStyles.appTextColor),
            textAlign: TextAlign.center,
          ),
        ),
      ));
    }
  }
}
