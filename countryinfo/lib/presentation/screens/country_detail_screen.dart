import 'package:countryinfo/model/country_model.dart';
import 'package:countryinfo/presentation/theme/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/country_detail_screen_bloc/country_detail_screen_bloc.dart';
import '../../bloc/country_detail_screen_bloc/country_detail_screen_event.dart';
import '../../bloc/country_detail_screen_bloc/country_detail_screen_state.dart';
import '../../helper/constants/text_contstants.dart';

class CountryDetailScreen extends StatefulWidget {
  String countryCode;
  CountryDetailScreen({Key? key, required this.countryCode}) : super(key: key);

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  late CountryDetailScreentBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = CountryDetailScreentBloc()
      ..add(InitEvent(countryCode: widget.countryCode));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: SafeArea(
        child: Scaffold(
          body:
              BlocConsumer<CountryDetailScreentBloc, CountryDetailScreenState>(
            listener: (BuildContext context, CountryDetailScreenState state) {
              if (state is FailureState) {}
            },
            builder: (_, CountryDetailScreenState state) {
              return SingleChildScrollView(
                child: Container(
                  child: StreamBuilder<Countries>(
                      stream: _bloc.countryStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return mainCountryDetailbody(snapshot);
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.red[400],
                              ),
                            ),
                          );
                        }
                      }),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget mainCountryDetailbody(AsyncSnapshot<Countries> snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8),
            child: countryCardView(snapshot)),
      ],
    );
  }

  Widget countryCardView(AsyncSnapshot<Countries> snapshot) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            countryCardTitleView(snapshot),
            Text(
              COUNTRY_DETAIL_CONTINET_LABEL +
                  snapshot.data!.continent!.name.toString(),
              style: Theme.of(context).textTheme.bodyTextStyle,
            ),
            Text(
              COUNTRY_DETAIL_PHONE_LABEL + snapshot.data!.phone.toString(),
              style: Theme.of(context).textTheme.bodyTextStyle,
            ),
            Text(
              COUNTRY_DETAIL_CAPITAL_LABEL + snapshot.data!.capital.toString(),
              style: Theme.of(context).textTheme.bodyTextStyle,
            ),
            Text(
              COUNTRY_DETAIL_COURRENCY_LABEL +
                  snapshot.data!.currency.toString(),
              style: Theme.of(context).textTheme.bodyTextStyle,
            ),
            (snapshot.data!.languages!.length != 0)
                ? languagesList(snapshot.data!)
                : Container(),
            (snapshot.data!.states!.length != 0)
                ? stateList(snapshot.data!)
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget countryCardTitleView(AsyncSnapshot<Countries> snapshot) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            snapshot.data!.emoji.toString(),
            style: Theme.of(context).textTheme.flagTextStyle,
          ),
          Flexible(
            child: Text(
                snapshot.data!.name.toString() +
                    " (" +
                    snapshot.data!.native.toString() +
                    ")",
                style: Theme.of(context).textTheme.headingTextStyle),
          ),
        ]),
      ],
    );
  }

  Widget languagesList(Countries countries) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          COUNTRY_DETAIL_LANGUAGES_LABEL,
          style: Theme.of(context).textTheme.bodyTextStyle,
        ),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount:
                  countries.languages == null ? 0 : countries.languages!.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Text(
                  countries.languages![index].name.toString(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyTextStyle,
                );
              }),
        )
      ],
    );
  }

  Widget stateList(Countries countries) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(COUNTRY_DETAIL_STATES_LABEL,
            style: Theme.of(context)
                .textTheme
                .bodyTextStyle
                .copyWith(fontSize: 16)),
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  countries.states == null ? 0 : countries.states!.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Text(
                  countries.states![index].name.toString(),
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyTextStyle,
                );
              }),
        )
      ],
    );
  }
}
