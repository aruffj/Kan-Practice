import 'package:kanpractice/core/jisho/models/jisho_data.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

class JishoAPI {
  /// Singleton instance of [JishoAPI]
  static JishoAPI instance = JishoAPI();

  Future<jisho.KanjiResultData?> searchKanji(String kanji) async {
    jisho.KanjiResult res = await jisho.searchForKanji(kanji);
    return res.data;
  }

  Future<List<jisho.JishoResult>> searchPhrase(String kanji) async {
    jisho.JishoAPIResult res = await jisho.searchForPhrase(kanji);
    List<jisho.JishoResult>? resData = res.data;
    List<jisho.JishoResult> data = [];
    if (resData != null) data = resData;
    return data;
  }

  Future<List<KanjiExample>> searchForExample(String kanji) async {
    jisho.ExampleResults res = await jisho.searchForExamples(kanji);
    List<KanjiExample> examples = [];
    res.results.forEach((example) {
      examples.add(KanjiExample(
          kanji: example.kanji,
          kana: example.kana,
          english: example.english,
          jishoUri: res.uri
      ));
    });
    return examples;
  }
}