import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterpoc/Framework/framework.dart';
import 'package:flutterpoc/constants.dart' as constants;
import 'package:flutterpoc/Insight/Kanban/boardview.dart';
import 'package:flutterpoc/Insight/Widgets/board_header.dart';
import 'package:flutterpoc/Insight/Widgets/board_card.dart';

class Insight extends StatefulWidget {
  const Insight({super.key});

  @override
  State<Insight> createState() => _MyAppState();
}

class _MyAppState extends State<Insight> {
  List jsonData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String activeUser = prefs.getString('activeUser') ?? "";
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      jsonData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BoardList> boardLists = [];
    List<BoardItem> boardItems = [];

    jsonData.forEach(
      (element) {
        boardItems = [];
        element["items"].forEach(
          (item) {
            boardItems.add(
              BoardItem(
                onStartDragItem:
                    (int? listIndex, int? itemIndex, BoardItemState? state) {},
                onDropItem: (int? listIndex, int? itemIndex, int? oldListIndex,
                    int? oldItemIndex, BoardItemState? state) {},
                onTapItem: (int? listIndex, int? itemIndex,
                    BoardItemState? state) async {},
                item: BoardCard(title: item),
              ),
            );
          },
        );

        boardLists.add(
          BoardList(
            onStartDragList: (int? listIndex) {},
            onTapList: (int? listIndex) async {},
            onDropList: (int? listIndex, int? oldListIndex) {},
            header: [
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: BoardHeader(title: element["header"])),
              ),
            ],
            items: boardItems,
          ),
        );
      },
    );

    var body = BoardView(
        lists: boardLists,
        boardViewController: BoardViewController(),
        width: MediaQuery.of(context).size.width);

    return Framework(element: body, title: 'Insight');
  }
}
