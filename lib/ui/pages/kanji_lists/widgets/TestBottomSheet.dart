import 'package:flutter/material.dart';
import 'package:kanpractice/ui/pages/kanji_lists/widgets/StudyBottomSheet.dart';
import 'package:kanpractice/ui/widgets/BlitzBottomSheet.dart';
import 'package:kanpractice/ui/widgets/DragContainer.dart';
import 'package:kanpractice/ui/theme/consts.dart';
import 'package:kanpractice/ui/widgets/CustomButton.dart';
import 'package:easy_localization/easy_localization.dart';

enum Tests {
  lists, blitz, time
}

extension TestsExt on Tests {
  String get name {
    switch (this) {
      case Tests.lists:
        return "test_mode_selection".tr();
      case Tests.blitz:
        return "test_mode_blitz".tr();
      case Tests.time:
        return "test_mode_remembrance".tr();
    }
  }

  IconData get icon {
    switch (this) {
      case Tests.lists:
        return Icons.select_all_rounded;
      case Tests.blitz:
        return Icons.flash_on_rounded;
      case Tests.time:
        return Icons.access_time_rounded;
    }
  }
}

class TestBottomSheet extends StatefulWidget {
  const TestBottomSheet();

  @override
  _TestBottomSheetState createState() => _TestBottomSheetState();

  /// Creates and calls the [BottomSheet] with the content for a regular test
  static Future<String?> callTestModeBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TestBottomSheet()
    );
  }
}

class _TestBottomSheetState extends State<TestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) {
        return Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DragContainer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Margins.margin8, horizontal: Margins.margin32),
                  child: Text("test_selection_label".tr(), textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizes.fontSize18)),
                ),
                Container(
                  height: CustomSizes.defaultSizeButtonHeight,
                  margin: EdgeInsets.only(bottom: Margins.margin32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _testBasedButtons(context, Tests.lists),
                      _testBasedButtons(context, Tests.blitz),
                      _testBasedButtons(context, Tests.time)
                    ],
                  ),
                ),
              ],
            ),
          ]
        );
      },
    );
  }

  CustomButton _testBasedButtons(BuildContext context, Tests mode) {
    return CustomButton(
      icon: mode.icon,
      title2: mode.name,
      color: CustomColors.secondarySubtleColor,
      onTap: () async {
        switch (mode) {
          case Tests.lists:
            await StudyBottomSheet.callStudyModeBottomSheet(context);
            break;
          case Tests.blitz:
            await BlitzBottomSheet.callBlitzModeBottomSheet(context);
            break;
          case Tests.time:
            await BlitzBottomSheet.callBlitzModeBottomSheet(context, remembranceTest: true);
            break;
        }
      }
    );
  }
}