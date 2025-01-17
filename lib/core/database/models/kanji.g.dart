// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kanji _$KanjiFromJson(Map<String, dynamic> json) => Kanji(
      kanji: json['kanji'] as String,
      listName: json['name'] as String,
      meaning: json['meaning'] as String,
      pronunciation: json['pronunciation'] as String,
      winRateReading: (json['winRateReading'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      winRateRecognition: (json['winRateRecognition'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      winRateWriting: (json['winRateWriting'] as num?)?.toDouble() ??
          DatabaseConstants.emptyWinRate,
      dateAdded: json['dateAdded'] as int? ?? 0,
      dateLastShown: json['dateLastShown'] as int? ?? 0,
    );

Map<String, dynamic> _$KanjiToJson(Kanji instance) => <String, dynamic>{
      'kanji': instance.kanji,
      'name': instance.listName,
      'meaning': instance.meaning,
      'pronunciation': instance.pronunciation,
      'winRateWriting': instance.winRateWriting,
      'winRateReading': instance.winRateReading,
      'winRateRecognition': instance.winRateRecognition,
      'dateAdded': instance.dateAdded,
      'dateLastShown': instance.dateLastShown,
    };
