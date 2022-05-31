import 'package:countryinfo/model/country_model.dart';
import 'package:flutter/material.dart';
import '../../../helper/constants/text_contstants.dart';

class CustomSearrchDelegate extends SearchDelegate<String> {
  List<Countries> countryList;
  CustomSearrchDelegate(this.countryList, this.onTapSearchSuggesstion);
  Function onTapSearchSuggesstion;
  bool isQueryMatch = false;

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              query = '';
            })
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.chevron_left),
      onPressed: () {
        close(context, '');
      });

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> listToShow = [];
    isQueryMatch = false;
    if (query.isNotEmpty) {
      countryList.forEach((element) {
        if (element.code!.toLowerCase().contains(query.toLowerCase())) {
          listToShow.add(element.code.toString());
          isQueryMatch = true;
        }
        if (element.name!.toLowerCase().contains(query.toLowerCase())) {
          listToShow.add(element.name.toString());
          isQueryMatch = true;
        }
      });
      if (!isQueryMatch) {
        listToShow.add(SEARCH_NOT_FOUND_ERROR);
      }
    } else {
      countryList.forEach((element) {
        listToShow.add(element.name.toString());
      });
    }
    return ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (_, i) {
        var searchedCountry = listToShow[i];
        return ListTile(
          title: Text(searchedCountry),
          onTap: () {
            if (isQueryMatch) {
              onTapSearchSuggesstion(countryList
                  .where((element) =>
                      element.code == listToShow[i] ||
                      element.name == listToShow[i])
                  .first);
            }
          },
        );
      },
    );
  }
}
