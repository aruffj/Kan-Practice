part of 'details_bloc.dart';

abstract class KanjiListDetailEvent extends Equatable {
  const KanjiListDetailEvent();

  @override
  List<Object> get props => [];
}

class KanjiEventLoading extends KanjiListDetailEvent {
  final String list;

  const KanjiEventLoading(this.list);

  @override
  List<Object> get props => [list];
}

class KanjiEventSearching extends KanjiListDetailEvent {
  final String query;
  final String list;

  const KanjiEventSearching(this.query, this.list);

  @override
  List<Object> get props => [query, list];
}

class UpdateKanList extends KanjiListDetailEvent {
  final String name;
  final String og;

  const UpdateKanList(this.name, this.og);

  @override
  List<Object> get props => [name, og];
}