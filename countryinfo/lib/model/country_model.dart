class CountryModel {
  List<Countries>? countriesList;

  CountryModel({this.countriesList});

  CountryModel.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countriesList = <Countries>[];
      json['countries'].forEach((v) {
        countriesList!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countriesList != null) {
      data['countries'] = this.countriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String? code;
  String? name;
  String? native;
  String? phone;
  Continent? continent;
  String? capital;
  String? currency;
  List<Languages>? languages;
  String? emoji;
  String? emojiU;
  List<States>? states;

  Countries(
      {this.code,
      this.name,
      this.native,
      this.phone,
      this.continent,
      this.capital,
      this.currency,
      this.languages,
      this.emoji,
      this.emojiU,
      this.states});

  Countries.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    native = json['native'];
    phone = json['phone'];
    continent = json['continent'] != null
        ? new Continent.fromJson(json['continent'])
        : null;
    capital = json['capital'];
    currency = json['currency'];
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['native'] = this.native;
    data['phone'] = this.phone;
    if (this.continent != null) {
      data['continent'] = this.continent!.toJson();
    }
    data['capital'] = this.capital;
    data['currency'] = this.currency;
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    data['emoji'] = this.emoji;
    data['emojiU'] = this.emojiU;
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Continent {
  String? name;

  Continent({this.name});

  Continent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Languages {
  String? name;

  Languages({this.name});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class States {
  String? name;

  States({this.name});

  States.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
