const String getCountriesQueryConst = r"""
  query GetCountries {
  countries {
    name
    emoji
    code
  }
}
""";
const String getCountryDetailQueryConst = r"""
    query GetContountry($code:ID!){
    country (code:$code){
    name
    native
    phone
    continent {
      name
    }
    capital
    currency
    languages {
      name
    }
    emoji
    states {
      name
    }
  }
}
""";
