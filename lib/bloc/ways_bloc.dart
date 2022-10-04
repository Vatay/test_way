import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ways/models/ways.dart';
import 'package:ways/services/network_helper.dart';

part 'ways_event.dart';
part 'ways_state.dart';

class WaysBloc extends Bloc<WaysEvent, WaysState> {
  String url = '';

  WaysBloc() : super(WaysInitial()) {
    on<WaysInitialScreen>((event, emit) async {
      url = await _getUrl();
      emit(WaysStartData(url: url));
    });

    on<WaysGetData>((event, emit) async {
      emit(WaysLoading());
      final networkHelper = NetworkHelper(event.url);
      List<Ways> waysList = [];

      dynamic data = await networkHelper.getData();
      if (data != null) {
        try {
          List<dynamic> dataList = data['data'];
          dataList.forEach((element) {
            final List<List<bool>> field = [];
            final List fieldList = element['field'];
            fieldList.forEach((i) {
              List<bool> row = [];
              i.toString().toUpperCase().split('').forEach((j) {
                if (j == 'X') {
                  row.add(false);
                } else {
                  row.add(true);
                }
              });
              field.add(row);
            });
            waysList.add(
              Ways(
                startX: element['start']['x'],
                startY: element['start']['y'],
                endX: element['end']['x'],
                endY: element['end']['y'],
                field: field,
              ),
            );
          });
          waysList.forEach((element) {
            element.searchShortWay();
          });
          await _setUrl(event.url);
          emit(WaysLoaded(waysList: waysList));
        } catch (e) {
          emit(WaysError('Error $e'));
        }
      }
    });

    on<WaysCalculate>((event, emit) {
      // TOD: implement event handler
    });

    on<WaysNoneEvent>((event, emit) {
      emit(WaysWaitEvents());
    });
  }
}

Future<String> _getUrl() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('urlAPI') ?? '';
}

Future<void> _setUrl(String url) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('urlAPI', url);
}
