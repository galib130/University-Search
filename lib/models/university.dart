// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));
List<Welcome> welcomeFromJsonName(String str,String query) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)
)).where((element) {
  final nameLower=element.name.toLowerCase();
  final queryLower=query.toLowerCase();

  return nameLower.contains(queryLower);

}).toList();

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    Welcome({
        required this.webPages,
        required this.domains,
        required this.alphaTwoCode,
        required this.country,
        required this.name,
        this.stateProvince,
    });

    List<String> webPages;
    List<String> domains;
    String alphaTwoCode;
    String country;
    String name;
    String? stateProvince;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
        domains: List<String>.from(json["domains"].map((x) => x)),
        alphaTwoCode: json["alpha_two_code"],
        country: json["country"],
        name: json["name"],
        stateProvince: json["state-province"],
    );


    Map<String, dynamic> toJson() => {
        "web_pages": List<dynamic>.from(webPages.map((x) => x)),
        "domains": List<dynamic>.from(domains.map((x) => x)),
        "alpha_two_code": alphaTwoCode,
        "country": country,
        "name": name,
        "state-province": stateProvince,
    };
}
