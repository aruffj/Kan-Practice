import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanpractice/core/database/database_consts.dart';
import 'package:kanpractice/core/database/models/kanji.dart';
import 'package:kanpractice/core/database/queries/kanji_queries.dart';
import 'package:kanpractice/ui/pages/kanji_lists/bloc/lists_bloc.dart';
import 'package:kanpractice/ui/widgets/StudyMode.dart';
import 'package:kanpractice/ui/theme/theme_consts.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:kanpractice/ui/widgets/EmptyList.dart';
import 'package:kanpractice/ui/widgets/ProgressIndicator.dart';

class StudyBottomSheet extends StatefulWidget {
  const StudyBottomSheet();

  @override
  _StudyBottomSheetState createState() => _StudyBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> callStudyModeBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StudyBottomSheet()
    );
  }
}

class _StudyBottomSheetState extends State<StudyBottomSheet> {
  List<Kanji> _kanji = [];
  List<String> _selectedLists = [];
  String _selectedFormattedLists = "";

  bool _selectionMode = false;

  Future<void> _loadKanjiFromListSelection(List<String> lists) async {
    _kanji = await KanjiQueries.instance.getKanjiBasedOnSelectedLists(lists);
    /// Keep the list names all the way to the Test Result page in a formatted way
    _selectedLists.forEach((name) => _selectedFormattedLists += "$name, ");
    _selectedFormattedLists = _selectedFormattedLists.substring(0, _selectedFormattedLists.length - 2);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: bottomSheetHeight,
          margin: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _dragContainer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                child: Text("Make a test with the KanLists of your choice",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Visibility(
                visible: _selectionMode,
                child: TestStudyMode(list: _kanji, listsNames: _selectedFormattedLists),
              ),
              Visibility(
                visible: !_selectionMode,
                child: BlocProvider(
                  create: (_) => KanjiListBloc()..add(KanjiListEventLoading(
                    filter: lastUpdatedField, order: false
                  )),
                  child: BlocBuilder<KanjiListBloc, KanjiListState>(
                    builder: (context, state) {
                      if (state is KanjiListStateFailure)
                        return EmptyList(message: "Failed to retrieve lists.");
                      else if (state is KanjiListStateLoading)
                        return CustomProgressIndicator();
                      else if (state is KanjiListStateLoaded) {
                        return Container(
                          height: bottomSheetHeight - 100,
                          margin: EdgeInsets.all(8),
                          child: _listSelection(state)
                        );
                      } else return Container();
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Column _listSelection(KanjiListStateLoaded state) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 2),
            itemCount: state.lists.length,
            itemBuilder: (context, index) {
              String name = state.lists[index].name;
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: ActionChip(
                  label: Text(name),
                  backgroundColor: _selectedLists.contains(name) ? secondaryColor : secondarySubtleColor,
                  onPressed: () {
                    setState(() {
                      if (_selectedLists.contains(name)) _selectedLists.remove(name);
                      else _selectedLists.add(name);
                    });
                  }
                ),
              );
            },
          ),
        ),
        CustomButton(
          title1: "終わり",
          title2: "Done",
          onTap: () async {
            if (_selectedLists.isNotEmpty) {
              await _loadKanjiFromListSelection(_selectedLists);
              setState(() => _selectionMode = true);
            }
          }
        )
      ],
    );
  }

  Align _dragContainer() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 90, height: 5,
        margin: EdgeInsets.only(bottom: 8, top: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.grey
        ),
      ),
    );
  }
}