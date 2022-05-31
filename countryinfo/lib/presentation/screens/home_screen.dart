import 'package:countryinfo/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_screen_bloc/home_screen_bloc.dart';
import '../../bloc/home_screen_bloc/home_screen_event.dart';
import '../../bloc/home_screen_bloc/home_screen_state.dart';
import '../../helper/constants/text_contstants.dart';
import 'widget/search_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String? _result;

  late HomeScreentBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = HomeScreentBloc()..add(InitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<HomeScreentBloc, HomeScreenState>(
        listener: (BuildContext context, HomeScreenState state) {
          if (state is FailureState) {}
        },
        builder: (_, HomeScreenState state) {
          if (state is LoadingState) {
            return Container(
              color: Colors.white.withOpacity(0.4),
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.red[400],
                ),
              ),
            );
          } else {
            return SafeArea(
                child: Scaffold(
                    drawerEnableOpenDragGesture: false,
                    key: scaffoldKey,
                    appBar: appbarBody(),
                    body: mainBody()));
          }
        },
      ),
    );
  }

  AppBar appbarBody() {
    return AppBar(
      backgroundColor: Colors.red[400],
      title: Text(HOME_PAGE_APPBAR_TITLE),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            var result = await showSearch<String>(
              context: context,
              delegate: CustomSearrchDelegate(_bloc.countryList,
                  (Countries searchedCountry) {
                _bloc.add(ButtonEvent(context,
                    countryCode: searchedCountry.code.toString()));
              }),
            );
            setState(() => _result = result);
          },
        ),
      ],
    );
  }

  Widget mainBody() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top + 58),
          child: StreamBuilder<List<Countries>>(
              stream: _bloc.countryListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return countryListView(snapshot);
                }
                return Container(
                  color: Colors.white.withOpacity(0.4),
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red[400],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget countryListView(AsyncSnapshot<List<Countries>> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return countryListTile(snapshot, index);
        });
  }

  Widget countryListTile(AsyncSnapshot<List<Countries>> snapshot, int index) {
    return Card(
      child: ListTile(
        tileColor: Colors.white60,
        leading: Text(snapshot.data![index].emoji.toString()),
        trailing: const Icon(Icons.arrow_forward_ios),
        title: Text(snapshot.data![index].name.toString()),
        onTap: () {
          _bloc.add(ButtonEvent(context,
              countryCode: snapshot.data![index].code.toString()));
        },
      ),
    );
  }
}
