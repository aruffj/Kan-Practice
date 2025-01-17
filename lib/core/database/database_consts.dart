class KanjiTableFields {
  static const String kanjiTable = "KANJI_TABLE";
  static const String kanjiField = "kanji";
  static const String listNameField = "name";
  static const String meaningField = "meaning";
  static const String pronunciationField = "pronunciation";
  static const String winRateWritingField = "winRateWriting";
  static const String winRateReadingField = "winRateReading";
  static const String winRateRecognitionField = "winRateRecognition";
  static const String dateAddedField = "dateAdded";
  static const String dateLastShown = "dateLastShown";
}

class KanListTableFields {
  static const String listsTable = "LISTS_TABLE";
  static const String nameField = "name";
  static const String totalWinRateWritingField = "totalWinRateWriting";
  static const String totalWinRateReadingField = "totalWinRateReading";
  static const String totalWinRateRecognitionField = "totalWinRateRecognition";
  static const String lastUpdatedField = "lastUpdated";
}

class TestTableFields {
  static const String testTable = "TEST_RESULT_TABLE";
  static const String testIdField = "id";
  static const String takenDateField = "takenDate";
  static const String testScoreField = "score";
  static const String kanjiInTestField = "totalKanji";
  static const String kanjiListsField = "kanjiLists";
  static const String studyModeField = "studyMode";
}

class DatabaseConstants {
  static const double emptyWinRate = -1;
}