import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tournami/custom.dart';
import 'package:tournami/detail.dart';
import 'package:tournami/model.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as Math;
import 'package:firebase_storage/firebase_storage.dart';

CardPlace? card;

class ResultPage extends StatefulWidget {
  const ResultPage({
    Key? key,
    this.query = "",
  }) : super(key: key);
  final String query;
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final endpoint =
      "https://tournami.ent.asia-southeast1.gcp.elastic-cloud.com/api/as/v1/engines/tournami/search";
  List picture = [];
  double userLat = 0;
  double userLong = 0;
  bool calculating = true;
  bool rankByScore = true;

  @override
  void initState() {
    picture.clear();
    sendQuery();

    super.initState();
  }

  Future<void> getImage(Result cardplace) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('pictures')
          .child(cardplace.id.raw.trim() + ".jpg");
      ref
          .getData(10000000)
          .then((data) => setState(() {
                cardplace.data = data;
              }))
          .catchError((e) => setState(() {
                print(e.toString());
              }));
      // ignore: avoid_print

    } catch (e) {
      print(e);
    }

    // return 's';
  }

  Future<void> sendQuery() async {
    var res = await http.post(
      Uri.parse(endpoint),
      headers: {"Authorization": "Bearer search-kkzaiz6xmkdhv4qhuvw4goiv"},
      body: {"query": widget.query},
    );

    if (res.statusCode == 200) {
      setState(() {
        card = cardPlaceFromJson(res.body);
      });

      for (Result item in card?.results ?? []) {
        await getImage(item);
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);

      setState(() {
        calculating = false;
        userLat = position.latitude;
        userLong = position.longitude;
      });
    }
  }

  double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(deg2rad(lat1)) *
            Math.cos(deg2rad(lat2)) *
            Math.sin(dLon / 2) *
            Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  double deg2rad(deg) {
    return deg * (Math.pi / 180);
  }

  Widget resultCard(CardPlace? cardplace, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => DetailPage(
                      card: cardplace?.results[index] ??
                          Result(
                              country: Activity(raw: 'raw'),
                              img: Activity(raw: 'raw'),
                              address: Activity(raw: 'raw'),
                              activity: Activity(raw: 'raw'),
                              city: Activity(raw: 'raw'),
                              latlong: Activity(raw: 'raw'),
                              name: Activity(raw: 'raw'),
                              detail: Activity(raw: 'raw'),
                              category: Activity(raw: 'raw'),
                              meta: MetaClass(
                                  engine: 'engine', score: 0, id: 'id'),
                              id: Activity(raw: 'raw'))),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: cardplace?.results[index].data == null
                        ? const Icon(
                            Icons.image_search_rounded,
                            size: 22,
                          )
                        : Hero(
                            tag: cardplace?.results[index].data.toString() ??
                                Uint8List(4).toString(),
                            transitionOnUserGestures: true,
                            child: Image.memory(
                              cardplace?.results[index].data ?? Uint8List(4),
                              // Image.network(cardplace?.results[index].img.raw ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(cardplace?.results[index].name.raw ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.04),
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          cardplace?.results[index].address.raw ?? '',
                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: MediaQuery.of(context).size.width * 0.023),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        calculating
                            ? 'Distance: calculating...'
                            : 'Distance: ' +
                                getDistanceFromLatLonInKm(
                                        userLat,
                                        userLong,
                                        double.parse(cardplace
                                                ?.results[index].latlong.raw
                                                .replaceAll(" ", "")
                                                .split(",")[0] ??
                                            '0'),
                                        double.parse(cardplace
                                                ?.results[index].latlong.raw
                                                .replaceAll(" ", "")
                                                .split(",")[1] ??
                                            '0'))
                                    .toInt()
                                    .toString() +
                                " km",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.023),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      
                      // Text(
                      //   'Search score: ' +
                      //       (cardplace?.results[index].meta.score.toString() ??
                      //           '0.0'),
                      //   style: Theme.of(context).textTheme.caption,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, left: 3.0),
            child: ClipRRect(
              child: Container(
                color: index == 0
                    ? Colors.green[600]
                    : index == 1
                        ? Colors.green
                        : index == 2
                            ? Colors.green[400]
                            : Colors.black,
                child: Text(
                  " " +
                      ((index + 1).toString() +
                              (!rankByScore && index == 0
                                  ? " nearest to you"
                                  : ""))
                          .toString() +
                      " ",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ],
      ),
    );
  }

  void rankByDistance() {
    if (!calculating) {
      setState(() {
        rankByScore = false;
        card?.results.sort((a, b) => getDistanceFromLatLonInKm(
                userLat,
                userLong,
                double.parse(a.latlong.raw.replaceAll(" ", "").split(",")[0]),
                double.parse(a.latlong.raw.replaceAll(" ", "").split(",")[1]))
            .toInt()
            .compareTo(getDistanceFromLatLonInKm(
                    userLat,
                    userLong,
                    double.parse(
                        b.latlong.raw.replaceAll(" ", "").split(",")[0]),
                    double.parse(
                        b.latlong.raw.replaceAll(" ", "").split(",")[1]))
                .toInt()));
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 8,
          title: Text("Waiting for gps to get your location...",
              style: Theme.of(context).textTheme.caption),
        ),
      );
    }
  }

  void _rankByScore() {
    if (!calculating) {
      setState(() {
        rankByScore = true;
        card?.results.sort((a, b) =>
            b.meta.score.toDouble().compareTo(a.meta.score.toDouble())); // dsc
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 8,
          title: Text("Waiting for gps to get your location...",
              style: Theme.of(context).textTheme.caption),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Result for ' " + widget.query + " '"),
      ),
      body: Column(
        children: [
          Expanded(
              // ignore: prefer_is_empty
              child: card?.results.length != 0
                  ? ListView.builder(
                      itemBuilder: (contex, index) => resultCard(card, index),
                      itemCount: card?.results.length,
                    )
                  : const Center(child: Text("No result found!"))),
        ],
      ),
      floatingActionButton: rankByScore
          ? FloatingActionButton(
              onPressed: rankByDistance,
              tooltip: 'Rank by distance',
              child: const Icon(Icons.gps_fixed_rounded),
            )
          : FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: _rankByScore,
              tooltip: 'Rank by score',
              child: const Icon(Icons.sort_rounded),
            ),
    );
  }
}
