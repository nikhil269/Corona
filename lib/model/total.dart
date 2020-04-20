class Total {
  final int updated;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;
  final int critical;
  final int tests;
  final int affectedCountries;

  Total({
    this.updated,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.tests,
    this.affectedCountries,
    this.cases,
    this.todayCases}
  );

  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      cases: json['cases'],
      todayCases: json['todayCases'],
      updated: json['updated'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      active: json['active'],
      critical: json['critical'],
      affectedCountries: json['affectedCountries'],
    );
  }
}
