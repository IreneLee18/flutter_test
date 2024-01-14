import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/favorite_places/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

const databaseName = 'place';

Future<Database> _getDatabase() async {
  // 目的：將資料存取在資料庫中
  // 創建一個資料庫的目錄
  final dbPath = await sql.getDatabasesPath();
  // 打開資料庫，並傳入自己創建的資料庫目錄路徑
  // 當試圖打開一個還不存在的資料庫，sqlLite 會自動為我們創建一個資料庫
  final db = await sql.openDatabase(
    path.join(dbPath, '$databaseName.db'),
    // onCreate: 會在我們第一次創建資料庫時執行
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $databaseName(id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );

  return db;
}

class PlaceNotifier extends StateNotifier<List<PlaceItem>> {
  PlaceNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    // 獲取資料庫資料的方式
    final data = await db.query(databaseName);
    final List<PlaceItem> places = data
        .map((row) => PlaceItem(
              id: row['id'] as String,
              name: row['name'] as String,
              image: File(row['image'] as String),
              location: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                address: row['address'] as String,
              ),
            ))
        .toList();

    state = places;
  }

  void addPlace({
    required String name,
    required File image,
    required PlaceLocation location,
  }) async {
    // 目的：儲存照片數據路徑
    // 取得應用程式的文件目錄
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // 取得圖片檔案的基本檔案名稱（不包含路徑）
    final fileName = path.basename(image.path);
    // 使用 copy 方法將選擇的圖片檔案複製到應用程式文件目錄
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = PlaceItem(
      id: DateTime.now().toString(),
      name: name,
      image: copiedImage,
      location: location,
    );

    final db = await _getDatabase();

    // 將資料存在資料庫裡面
    db.insert(databaseName, {
      'id': newPlace.id,
      'name': newPlace.name,
      'image': newPlace.image!.path,
      'lat': newPlace.location!.latitude,
      'lng': newPlace.location!.longitude,
      'address': newPlace.location!.address,
    });

    state = [newPlace, ...state];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<PlaceItem>>(
  (ref) => PlaceNotifier(),
);
