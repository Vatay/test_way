class Ways {
  final int startX;
  final int startY;
  final int endX;
  final int endY;
  bool teleport = false;
  final List<List<bool>> field;
  List<List<int>> shortWay = [];
  String shortWayText = '';
  int gredSize = 1;
  Ways({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.field,
  });

  void searchShortWay() {
    shortWay = [];
    shortWay.add([startY, startX]);
    int stepXNow = startX;
    int stepYNow = startY;
    int stepXPrev = startX;
    int stepYPrev = startY;

    int row = startX < endX ? endX : startX;
    int column = startY < endY ? endY : startY;

    gredSize = (row < column ? column : row) + 1;

    while (stepXNow != endX || stepYNow != endY) {
      if (stepXNow > endX) {
        stepXNow--;
      } else if (stepXNow < endX) {
        stepXNow++;
      }
      if (stepYNow > endY) {
        stepYNow--;
      } else if (stepYNow < endY) {
        stepYNow++;
      }

      // field
      if (field[stepYNow][stepXNow]) {
        // short
        shortWay.add([stepYNow, stepXNow]);
        stepXPrev = stepXNow;
        stepYPrev = stepYNow;
      } else if (field[stepYPrev][stepXNow]) {
        shortWay.add([stepYPrev, stepXNow]);
        stepXPrev = stepXNow;
      } else if (field[stepYNow][stepXPrev]) {
        shortWay.add([stepYNow, stepXPrev]);
        stepYPrev = stepYNow;
      } else {
        // error
        teleport = true;
        shortWay.add([endY, endX]);
        break;
      }

      // print
    }
    if (teleport) {
      shortWay = [
        [startY, startX],
        [endY, endX],
      ];
      shortWayText = 'Маршрут складний... Використано телепорт!)';
    } else {
      shortWayText = '(';
      shortWay.forEach((element) {
        shortWayText += ' (${element[1]}, ${element[0]}) ';
      });
      shortWayText += ')';
    }
  }
}
