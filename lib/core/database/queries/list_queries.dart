import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:kanpractice/core/utils/GeneralUtils.dart';
import 'package:sqflite/sqflite.dart';

class ListQueries {
  Database? _database;
  /// Singleton instance of [ListQueries]
  static ListQueries instance = ListQueries();

  ListQueries() { _database = CustomDatabase.instance.database; }

  /// Creates a [KanjiList] and inserts it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during insertion.
  ///
  /// 2: Database is not created.
  Future<int> createList(String name) async {
    if (_database != null) {
      try {
        await _database?.insert(listsTable, KanjiList(name: name, lastUpdated: GeneralUtils.getCurrentMilliseconds()).toJson());
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else return -2;
  }

  /// Query to get all [KanjiList] from the db with an optional [order] and [filter].
  /// If anything goes wrong, an empty list will be returned.
  Future<List<KanjiList>> getAllLists({String filter = lastUpdatedField, String order = "DESC"}) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery("SELECT * FROM $listsTable ORDER BY $filter $order");
        if (res != null) return List.generate(res.length, (i) => KanjiList.fromJson(res![i]));
        else return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else return [];
  }

  /// Query to get all [KanjiList] from the db based on a [query] that will match:
  /// list name, kanji, meaning and pronunciation.
  /// If anything goes wrong, an empty list will be returned.
  Future<List<KanjiList>> getListsMatchingQuery(String query) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.rawQuery(
          "SELECT DISTINCT L.$nameField, L.$totalWinRateWritingField, L.$totalWinRateReadingField, "
          "L.$totalWinRateRecognitionField, L.$lastUpdatedField FROM $listsTable L JOIN $kanjiTable K "
          "ON K.$listNameField=L.$nameField "
          "WHERE L.$nameField LIKE '%$query%' OR K.$meaningField LIKE '%$query%' "
          "OR K.$kanjiField LIKE '%$query%' OR K.$pronunciationField LIKE '%$query%' "
          "ORDER BY $lastUpdatedField DESC"
        );
        if (res != null) return List.generate(res.length, (i) => KanjiList.fromJson(res![i]));
        else return [];
      } catch (err) {
        print(err.toString());
        return [];
      }
    } else return [];
  }

  /// Query to get a [KanjiList] based on its [name].
  /// If anything goes wrong, a [KanjiList.empty] will be returned.
  Future<KanjiList> getList(String name) async {
    if (_database != null) {
      try {
        List<Map<String, dynamic>>? res = [];
        res = await _database?.query(listsTable, where: "$listNameField=?", whereArgs: [name]);
        if (res != null) return KanjiList.fromJson(res[0]);
        else return KanjiList.empty;
      } catch (err) {
        print(err.toString());
        return KanjiList.empty;
      }
    } else return KanjiList.empty;
  }

  /// Gets a [KanjiList] and removes it from the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during removal.
  ///
  /// 2: Database is not created.
  Future<int> removeList(String name) async {
    if (_database != null) {
      try {
        await _database?.delete(listsTable, where: "$listNameField=?", whereArgs: [name]);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else return -2;
  }

  /// Creates a [KanjiList] and updates it to the db.
  /// Returns an integer depending on the error given:
  ///
  /// 0: All good.
  ///
  /// 1: Error during update.
  ///
  /// 2: Database is not created.
  Future<int> updateList(String name, Map<String, dynamic> fields) async {
    if (_database != null) {
      try {
        await _database?.update(listsTable, fields, where: "$listNameField=?", whereArgs: [name]);
        return 0;
      } catch (err) {
        print(err.toString());
        return -1;
      }
    } else return -2;
  }
}