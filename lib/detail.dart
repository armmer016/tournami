import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tournami/location.dart';
import 'package:tournami/model.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.card}) : super(key: key);
  final Result card;
  final ScrollController _scroll = ScrollController();
  final String token =
      'pk.eyJ1IjoiYXJtbWVyMDE2IiwiYSI6ImNsMjlmb3hscDAwNW8zY3BpcHk1YmFsd20ifQ.m8WSXwHuKTLWyzOwDXhVIg';
  final String style = 'mapbox://styles/armmer016/cl29gb6en004915ql2asaom73';
  @override
  Widget build(BuildContext context) {
    // print(card.latlong.raw.replaceAll(" ", "").split(",")[1]);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scroll,
              child: Stack(
                children: [
                  Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.08),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Hero(
                              tag: card.data.toString(),
                              transitionOnUserGestures: true,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                child: Image.memory(
                                  card.data ?? Uint8List(4),
                                  // height: MediaQuery.of(context).size.width / 3,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.08),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    card.name.raw,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Card(
                                // margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          card.detail.raw,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Activities",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Card(
                                // margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          card.activity.raw,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Address",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Card(
                                // margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          card.address.raw,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Map",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: MapboxMap(
                                  accessToken: token,
                                  styleString: style,
                                  myLocationEnabled: true,
                                  doubleClickZoomEnabled: true,
                                  trackCameraPosition: true,
                                  initialCameraPosition: CameraPosition(
                                    zoom: 8.0,
                                    target: LatLng(
                                        double.parse(card.latlong.raw
                                            .replaceAll(" ", "")
                                            .split(",")[0]),
                                        double.parse(card.latlong.raw
                                            .replaceAll(" ", "")
                                            .split(",")[1])),
                                  ),
                                  onMapCreated:
                                      (MapboxMapController controller) async {
                                    // Acquire current location (returns the LatLng instance)
                                    // final result =
                                    //     await acquireCurrentLocation();

                                    // You can either use the moveCamera or animateCamera, but the former
                                    // causes a sudden movement from the initial to 'new' camera position,
                                    // while animateCamera gives a smooth animated transition
                                    // await controller.animateCamera(
                                    //   CameraUpdate.newLatLng(result),
                                    // );

                                    // Add a circle denoting current user location
                                    await controller.addCircle(
                                      CircleOptions(
                                        circleStrokeWidth: 1,
                                        circleRadius: 8.0,
                                        circleColor: '#006992',
                                        circleOpacity: 0.8,

                                        // YOU NEED TO PROVIDE THIS FIELD!!!
                                        // Otherwise, you'll get a silent exception somewhere in the stack
                                        // trace, but the parameter is never marked as @required, so you'll
                                        // never know unless you check the stack trace
                                        geometry: LatLng(
                                        double.parse(card.latlong.raw
                                            .replaceAll(" ", "")
                                            .split(",")[0]),
                                        double.parse(card.latlong.raw
                                            .replaceAll(" ", "")
                                            .split(",")[1])),
                                        draggable: false,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
