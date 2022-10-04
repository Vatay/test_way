import 'package:flutter/material.dart';
import 'package:ways/colors.dart';
import 'package:ways/models/ways.dart';

class ShortWayScreen extends StatelessWidget {
  final Ways myWay;
  const ShortWayScreen({required this.myWay});
  @override
  Widget build(BuildContext context) {
    int i = -1;
    int j = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Коротка дорога'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (myWay.teleport)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Алгоритм пошуку шляху заслабкий, було використано телепорт',
                style: TextStyle(fontSize: 18),
              ),
            ),
          Expanded(
            child: (myWay.gredSize * myWay.gredSize > 100 ||
                    myWay.gredSize * myWay.gredSize <= 1)
                ? Text('Дуже страшне поле, перевірте данні')
                : GridView.builder(
                    itemCount: myWay.gredSize * myWay.gredSize,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: myWay.gredSize,
                    ),
                    itemBuilder: (context, index) {
                      i++;
                      if (i == myWay.gredSize) {
                        i = 0;
                        j++;
                      }
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: _bgColor(i, j),
                        ),
                        child: Center(
                          child: Text('($i, $j)'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color? _bgColor(int i, int j) {
    if (myWay.startY == j && myWay.startX == i) {
      return kColorStar;
    }
    if (myWay.endY == j && myWay.endX == i) {
      return kColorEnd;
    }
    if (!myWay.field[j][i]) {
      return kColorBlock;
    }
    for (var n = 0; n < myWay.shortWay.length; n++) {
      if (myWay.shortWay[n][0] == j && myWay.shortWay[n][1] == i) {
        return kColorLine;
      }
    }
    return null;
  }
}
