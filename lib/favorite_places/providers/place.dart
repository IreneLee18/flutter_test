import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/favorite_places/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class PlaceNotifier extends StateNotifier<List<PlaceItem>> {
  PlaceNotifier() : super(const []);

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

    state = [newPlace, ...state];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<PlaceItem>>(
  (ref) => PlaceNotifier(),
);
