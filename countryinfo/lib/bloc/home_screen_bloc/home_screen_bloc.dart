import 'dart:async';

import 'package:countryinfo/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/qraphql_queries.dart';
import '../../presentation/screens/country_detail_screen.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreentBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  List<Countries> countryList = [];
  HomeScreentBloc() : super(InitState());
  Queries graphQueries = Queries();
  final _countryListStreamController = BehaviorSubject<List<Countries>>();
  Stream<List<Countries>> get countryListStream =>
      _countryListStreamController.stream;
  StreamSink<List<Countries>> get countryListSink {
    return _countryListStreamController.sink;
  }

  Function(List<Countries>) get countryListChanged =>
      _countryListStreamController.sink.add;
  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is InitEvent) {
      yield LoadingState();
      countryList = await graphQueries.getCountriesList();
      List<Languages> list = [];

      _countryListStreamController.value = countryList;
      yield SuccessfulState();
    } else if (event is ButtonEvent) {
      Navigator.of(event.context).push(
        MaterialPageRoute(
          builder: (context) => CountryDetailScreen(
            countryCode: event.countryCode,
          ),
        ),
      );
    }
  }
}
