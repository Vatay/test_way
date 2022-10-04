import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ways/bloc/ways_bloc.dart';
import 'package:ways/models/ways.dart';
import 'package:ways/screens/short_way_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fieldUrl = TextEditingController();
  bool calculating = false;
  List<Ways> waysList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    fieldUrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              fieldUrl.text = 'https://flutter.webspark.dev/flutter/api';
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<WaysBloc, WaysState>(
        builder: (context, state) {
          if (state is WaysStartData) {
            fieldUrl.text = state.url;
            context.read<WaysBloc>().add(WaysNoneEvent());
          }
          if (state is WaysLoading) {
            calculating = true;
          }
          if (state is WaysLoaded) {
            calculating = false;
            waysList = state.waysList;
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextField(
                  controller: fieldUrl,
                  decoration: InputDecoration(
                    hintText: 'Url',
                    prefixIcon: Icon(Icons.compare_arrows_sharp),
                  ),
                ),
                Expanded(
                  child: calculating
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          itemCount: waysList.length,
                          itemBuilder: (context, index) {
                            final waysItem = waysList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShortWayScreen(myWay: waysItem),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  color: Colors.grey[200],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Start positiom: x=${waysItem.startX}, y=${waysItem.startY}'),
                                      Text(
                                          'End positiom: x=${waysItem.endX}, y=${waysItem.endY}'),
                                      Text(
                                          'Short Way: ${waysItem.shortWayText}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: calculating ? null : _correctUrl,
                    child: Text('Start'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _correctUrl() {
    final String url = fieldUrl.text.trim();
    if (Uri.tryParse(url)?.hasAbsolutePath ?? false) {
      context.read<WaysBloc>().add(WaysGetData(url: url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Невірно введено URL',
            style: TextStyle(fontSize: 20),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
