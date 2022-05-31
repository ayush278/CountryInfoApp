import 'package:countryinfo/model/country_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'constants/graphql_constants.dart';

abstract class GraphQueries {
  late GraphQLClient _client;

  GraphQueries() {
    String _graphQLUrl = 'https://countries.trevorblades.com/graphql';
    final Link link = HttpLink(_graphQLUrl);
    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
  }
}

class Queries extends GraphQueries {
  Future getCountriesList() async {
    var result = await _client.query(
      QueryOptions(
        document: gql(getCountriesQueryConst),
      ),
    );
    CountryModel countryModel =
        CountryModel.fromJson(result.data as Map<String, dynamic>);
    countryModel.countriesList!
        .sort((a, b) => a.name!.toString().compareTo(b.name.toString()));

    return countryModel.countriesList;
  }

  Future getCountriesDetailInfo(String countryCode) async {
    var result = await _client.query(
      QueryOptions(
        document: gql(
          getCountryDetailQueryConst,
        ),
        variables: <String, dynamic>{"code": countryCode},
      ),
    );
    Countries countries = await Countries.fromJson(
        result.data!["country"] as Map<String, dynamic>);

    return countries;
  }
}
