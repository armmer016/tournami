import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tournami/model.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.card}) : super(key: key);
  final Result card;
  final ScrollController _scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    
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
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.14) ,
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
                                      MediaQuery.of(context).size.width / 1.8,
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
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.14),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    card.name.raw,
                                    style: Theme.of(context).textTheme.headline5!.copyWith(
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
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            color: Colors.black,
                                            fontSize: 18
                                            
                                          ),
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
                                    style: Theme.of(context).textTheme.headline5!.copyWith(
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
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            color: Colors.black,
                                            fontSize: 18
                                            
                                          ),
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
                                    style: Theme.of(context).textTheme.headline5!.copyWith(
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
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            color: Colors.black,
                                            fontSize: 18
                                            
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
