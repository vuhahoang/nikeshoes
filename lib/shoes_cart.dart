import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math' as math;

import 'package:learnflutternew/data/shoes_storage.dart';
import 'package:learnflutternew/model/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/shoes_model.dart';

int _countshoes = 0;

final ShoesStotageSC = AssetShoesStorage();

class ShoesCart extends StatefulWidget {
  const ShoesCart({Key? key}) : super(key: key);

  @override
  State<ShoesCart> createState() => _ShoesCartState();
}

List<String> listcard = [];
List<CardModel> cardMs = [];

class _ShoesCartState extends State<ShoesCart> {
  void saveCardShoes(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listcard = prefs.getStringList('itemcard') ?? [];
      listcard.add(id);
      prefs.setStringList('itemcard', listcard);

      print(listcard);
    });
  }

  void deleteCardShoes(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listcard = prefs.getStringList('itemcard') ?? [];
      listcard.remove(id);
      prefs.setStringList('itemcard', listcard);

      print(listcard);
    });
  }

  void loadCardShoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      listcard = prefs.getStringList('itemcard') ?? [];
      print("List card string" + listcard.toString());

      cardMs = [];
      print('List Card' + cardMs.toString());
      for (int i = 0; i < listcard.length; i++) {
        cardMs.add(new CardModel(number: 1, itemcount: listcard[i]));
        for (int j = i + 1; j < listcard.length; j++) {
          if (cardMs[i].itemcount == listcard[j]) {
            print(j.toString() + "  " + listcard[j]);
            listcard.removeAt(j);
            print('do dai lenght' + listcard.length.toString());
            print(listcard.toString());
            cardMs[i].setNumber = cardMs[i].getNumber + 1;
            j--;
          }
        }
      }

      print(cardMs.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadCardShoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(flex: 1, child: headingSC()),
          Expanded(
              flex: 8,
              child: FutureBuilder(
                  future: ShoesStotageSC.load(),
                  builder: (context, snapshot) {
                    if(cardMs.length == 0){
                      return  Column(
                        children: [
                          Expanded(flex: 6,child: FractionallySizedBox(heightFactor: 0.75,widthFactor: 0.75,child: Image(fit: BoxFit.cover,image: AssetImage('assets/empty.png')))),
                          Expanded(
                            flex: 4,
                            child: FractionallySizedBox(
                            heightFactor: 0.15,
                            widthFactor: 0.75,
                            alignment: Alignment.topCenter,
                            child: FittedBox(child: Text('My Cart Is Empty :('))))
                        ],
                      );
                    }
                    var item = snapshot.data as List<ShoesModel>;
                    return ListView.builder(
                      itemCount: cardMs.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.width * 0.45,
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: FractionallySizedBox(
                                              alignment: Alignment.center,
                                              heightFactor: 0.5,
                                              child: FittedBox(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(item[int.parse(
                                                          cardMs[index]
                                                              .itemcount)]
                                                      .name
                                                      .toString())),
                                            )),
                                        Expanded(
                                            child: FractionallySizedBox(
                                                alignment: Alignment.topLeft,
                                                heightFactor: 0.5,
                                                child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(item[int.parse(
                                                            cardMs[index]
                                                                .itemcount)]
                                                        .category![0]
                                                        .toString())))),
                                        Expanded(
                                            flex: 2,
                                            child: FractionallySizedBox(
                                                alignment: Alignment.topLeft,
                                                heightFactor: 0.5,
                                                child: FittedBox(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '\$' +
                                                          ((item[int.parse(cardMs[index]
                                                                              .itemcount)]
                                                                          .price! /
                                                                      100) *
                                                                  cardMs[index]
                                                                      .number)
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )))),
                                        Expanded(
                                            child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cardMs[index].number++;
                                                    saveCardShoes(cardMs[index]
                                                        .itemcount);
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(
                                                    Icons.add_sharp,
                                                    color: Colors.white,
                                                  ),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: FittedBox(
                                                    alignment: Alignment.center,
                                                    child: Text(cardMs[index]
                                                        .number
                                                        .toString()))),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cardMs[index].number--;
                                                    deleteCardShoes(
                                                        cardMs[index]
                                                            .itemcount);
                                                    if (cardMs[index].number ==
                                                        0) {
                                                      item.removeAt(index);
                                                    }
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                  backgroundColor: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Spacer(
                                              flex: 7,
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -50,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(math.pi),
                                  child: Image.network(
                                    item[int.parse(cardMs[index].itemcount)]
                                        .image
                                        .toString(),
                                    fit: BoxFit.cover,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.width *
                                        0.45,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    );
                  })),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: BottomSC(),
              ))
        ],
      )),
    );
  }
}

class headingSC extends StatelessWidget {
  const headingSC({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), //or 15.0
              child: Container(
                height: MediaQuery.of(context).size.width * 0.12,
                width: MediaQuery.of(context).size.width * 0.12,
                color: Colors.grey[200],
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 8,
          fit: FlexFit.tight,
          child: Container(
              height: MediaQuery.of(context).size.width * 0.12,
              child: Image(image: AssetImage('assets/logo.png'))),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

class BottomSC extends StatefulWidget {
  const BottomSC({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomSC> createState() => _BottomSCState();
}

class _BottomSCState extends State<BottomSC> {
  double priceTotal = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ShoesStotageSC.load(),
        builder: (context, snapshot) {
          var item = snapshot.data as List<ShoesModel>;
          priceTotal = 0;
          print('totalprice' + cardMs.toString());
          for (int i = 0; i < cardMs.length; i++) {
            priceTotal += ((item[int.parse(cardMs[i].itemcount)].price! / 100) *
                cardMs[i].number);
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: FittedBox(
                            alignment: Alignment.topLeft,
                            child: Text('Total Price'))),
                    Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: FittedBox(
                            alignment: Alignment.bottomLeft,
                            child: Text('\$' + priceTotal.toString())))
                  ],
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Add to Bag'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                    elevation: MaterialStateProperty.all(0),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
