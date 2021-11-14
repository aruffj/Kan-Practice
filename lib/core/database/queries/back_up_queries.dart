import 'package:kanpractice/core/database/database.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/models/list.dart';
import 'package:sqflite/sqflite.dart';

class BackUpQueries {
  Database? _database;
  /// Singleton instance of [BackUpQueries]
  static BackUpQueries instance = BackUpQueries();

  BackUpQueries() { _database = CustomDatabase.instance.database; }

  /// Merges the back up from Firebase to the local database.
  /// It takes as parameter [kanji] and [lists] to be MERGED into the
  /// local db.
  Future<String> mergeBackUp(List<Kanji> kanji, List<KanjiList> lists) async {
    if (_database != null) {
      try {
        /// Order matters as kanji depends on lists.
        /// Conflict algorithm allows us to merge the data from back up with current one.
        final batch = _database?.batch();
        for (int x = 0; x < lists.length; x++) {
          batch?.insert(listsTable, lists[x].toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
        }
        for (int x = 0; x < kanji.length; x++) {
          batch?.insert(kanjiTable, kanji[x].toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
        }
        final results = await batch?.commit();
        return results?.length == 0 ? "Batch failed" : "";
      } catch (err) {
        return err.toString();
      }
    } else return "Database is null";
  }
}