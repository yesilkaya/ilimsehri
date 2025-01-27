import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../view/models/ayet.dart';
import '../view/models/dua.dart';
import '../view/models/ehlibeyt.dart';
import '../view/models/munacat.dart';
import '../view/models/ramazan.dart';
import '../view/models/sahifeyi_seccadiye.dart';
import '../view/models/sure.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    } else {
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath(); // var olan veritabanı yolu alınıyor
    var path = join(databasesPath, "ilimsehri.db"); // Okununup yeniden olusturucak veritabanı

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/database", "ilimsehri.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    return await openDatabase(
      path,
      readOnly: false,
    );
  }

  Future<List<Map<String, dynamic>>> sureleriGetir() async {
    var db = await _getDatabase();
    var sonuc = await db.query("sure");
    return List<Map<String, dynamic>>.from(sonuc);
  }

  Future<List<Sure>> sureListesiniGetir() async {
    var sureleriIcerenMapListesi = await sureleriGetir();
    List<Sure> sureListesi = [];
    for (Map<String, dynamic> map in sureleriIcerenMapListesi) {
      sureListesi.add(Sure.fromMap(map));
    }
    return sureListesi;
  }

  Future<List<Map<String, dynamic>>> ayetleriGetir(int sureId) async {
    var db = await _getDatabase();
    var sonuc = await db.query("ayet", where: 'sure_id = ?', whereArgs: [sureId]);
    return List<Map<String, dynamic>>.from(sonuc);
  }

  Future<List<Ayet>> ayetlerListGetir(int sureId) async {
    var ayetleriIcerenMapListesi = await ayetleriGetir(sureId);
    List<Ayet> ayetListesi = [];
    for (Map<String, dynamic> map in ayetleriIcerenMapListesi) {
      ayetListesi.add(Ayet.fromMap(map));
    }
    return ayetListesi;
  }

  Future<List<Map<String, dynamic>>> duaGetir(int duaNo) async {
    var db = await _getDatabase();
    var sonuc = await db.query("sahifei_seccadiye", where: 'dua_no = ? and cumle_no >1', whereArgs: [duaNo]);
    return List<Map<String, dynamic>>.from(sonuc);
  }

  Future<List<SahifeiSeccadiye>> sahifeiSeccadiyeDuaListeGetir(int duaNo) async {
    var duaIcerenMap = await duaGetir(duaNo);
    List<SahifeiSeccadiye> duaListesi = [];
    for (Map<String, dynamic> map in duaIcerenMap) {
      duaListesi.add(SahifeiSeccadiye.fromMap(map));
    }
    return duaListesi;
  }

  Future<List<Map<String, dynamic>>> ehlibeytinHayatiListe(int masumID) async {
    var db = await _getDatabase();
    var sonuc = await db.query("ehlibeyt", where: 'id = ?', whereArgs: [masumID]);
    print("aa$sonuc");
    return List<Map<String, dynamic>>.from(sonuc);
  }

  Future<String> ehlibeytinHayatiListeGetir(int masumID) async {
    var ehlibeytinHayatiMap = await ehlibeytinHayatiListe(masumID);
    List<Ehlibeyt> ehlibeytinHayati = [];
    for (Map<String, dynamic> map in ehlibeytinHayatiMap) {
      ehlibeytinHayati.add(Ehlibeyt.fromMap(map));
    }
    return ehlibeytinHayati[0].hayati ?? '';
  }

  Future<List<Munacat>> munacatListeGetir(int munacatID) async {
    var db = await _getDatabase();
    var sonuc = await db.query("munacatlar", where: 'id = ?', whereArgs: [munacatID]);
    List<Munacat> munacatListe = [];
    for (Map<String, dynamic> map in sonuc) {
      munacatListe.add(Munacat.fromMap(map));
    }
    return munacatListe;
  }

  Future<List<Dua>> duaListeGetir(int duaID) async {
    var db = await _getDatabase();
    var sonuc = await db.query("dualar", where: 'dua_id = ?', whereArgs: [duaID], orderBy: "sira_id");
    List<Dua> duaListe = [];
    for (Map<String, dynamic> map in sonuc) {
      duaListe.add(Dua.fromMap(map));
    }
    return duaListe;
  }

  Future<List<Ramazan>> ramazanAmelListeGetir(int ramazanID) async {
    var db = await _getDatabase();
    var sonuc = await db.query("ramazan", where: 'ramazan_id = ?', whereArgs: [ramazanID], orderBy: "sira_id");
    List<Ramazan> duaListe = [];
    for (Map<String, dynamic> map in sonuc) {
      duaListe.add(Ramazan.fromMap(map));
    }
    return duaListe;
  }
}

/*
  Future<int> kategoriEkle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = await db.insert("kategori", kategori.toMap());
    return sonuc;
  }
  */

/*
  Future<int> kategoriGuncelle(Kategori kategori) async {
    var db = await _getDatabase();
    var sonuc = await db.update("kategori", kategori.toMap(),where:'kategoriID = ?',whereArgs: [kategori.kategoriID] );
    return sonuc;
  }
*/
/*
  Future<int> kategoriSil(int kategoriID) async {
    var db = await _getDatabase();
    var sonuc = await db.delete("kategori",where:'kategoriID = ?',whereArgs: [kategoriID] );
    return sonuc;
  }
*/

// Not Tablosu  Crud

/* Future<List<Map<String,dynamic>>>notlariGetir() async {
    var db =  await _getDatabase();
    var sonuc = await db.query("not",orderBy: 'notID DESC');
    return sonuc;
  }*/
/*
  Future<List<Map<String,dynamic>>> notlariGetir() async {
    var db =  await _getDatabase();
    var sonuc = await db.rawQuery('select * from "not" inner join kategori on kategori.kategoriID = "not".kategoriID order by notID Desc;');
    return sonuc;
  }
  */

/*
  // Veri tabanından gelen mapi liste dönüştürür
  Future<List<Not>> notListesiniGetir() async {
    var notlarMapListesi = await notlariGetir();
    var notListesi = List<Not>();
    for (Map map in notlarMapListesi){
      notListesi.add(Not.fromMap(map));
    }
    return notListesi;
  }
*/
/*
  Future<int> notEkle(Not not) async {
    var db = await _getDatabase();
    var sonuc = await db.insert("not", not.toMap());
    return sonuc;
  }
  */
/*
  Future<int> notGuncelle(Not not) async {
    var db = await _getDatabase();
    var sonuc = await db.update("not", not.toMap(),where:'notID = ?',whereArgs: [not.notID] );
    return sonuc;
  }
*/
/*
  Future<int> notSil(int notID) async {
    var db = await _getDatabase();
    var sonuc = await db.delete("not",where:'notID = ?',whereArgs: [notID] );
    return sonuc;
  }*/
