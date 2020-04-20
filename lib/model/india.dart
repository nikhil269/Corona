class India {
  final int active;

  India({this.active});

factory India.fromJson(Map<String, dynamic> json) {
    return India(
      active: json['active']
    );
  }


}
