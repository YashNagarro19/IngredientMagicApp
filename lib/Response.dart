class ResponseData {
  ResponseData({
  required this.rating,
  required this.avoid,
});
late final String rating;
late final String avoid;

  ResponseData.fromJson(Map<String, dynamic> json){
rating = json['rating'];
avoid = json['avoid'];
}

Map<String, dynamic> toJson() {
final _data = <String, dynamic>{};
_data['rating'] = rating;
_data['avoid'] = avoid;
return _data;
}
}