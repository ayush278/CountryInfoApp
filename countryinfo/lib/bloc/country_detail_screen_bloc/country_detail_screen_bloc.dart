import 'dart:async';

import 'package:countryinfo/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/qraphql_queries.dart';
import 'country_detail_screen_event.dart';
import 'country_detail_screen_state.dart';
import 'package:rxdart/rxdart.dart';

class CountryDetailScreentBloc
    extends Bloc<CountryDetailScreenEvent, CountryDetailScreenState> {
  late Countries countryModel;
  CountryDetailScreentBloc() : super(InitState());
  Queries graphQueries = Queries();
  final _countryStreamController = BehaviorSubject<Countries>();
  Stream<Countries> get countryStream => _countryStreamController.stream;
  StreamSink<Countries> get countrySink {
    return _countryStreamController.sink;
  }

  Function(Countries) get countryChanged => _countryStreamController.sink.add;
  @override
  Stream<CountryDetailScreenState> mapEventToState(
      CountryDetailScreenEvent event) async* {
    if (event is InitEvent) {
      yield LoadingState();
      countryModel =
          await graphQueries.getCountriesDetailInfo(event.countryCode);
      _countryStreamController.value = countryModel;
      //yield SuccessfulState();
    }
  }
}
