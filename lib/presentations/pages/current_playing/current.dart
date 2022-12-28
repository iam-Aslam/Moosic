// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../widgets/common.dart';

class current extends StatefulWidget {
  const current({super.key});

  @override
  State<current> createState() => _currentState();
}

var orientation, size, height, width;

class _currentState extends State<current> {
  @override
  Widget build(BuildContext context) {
    // getting the orientation of the app
    orientation = MediaQuery.of(context).orientation;

    //size of the window
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Column(
            children: [
              Container(
                width: width / 1,
                height: height / 1.68,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset(
                    'assets/images/default.jpg',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Times For the Anxious',
                          style: GoogleFonts.ebGaramond(
                            textStyle: TextStyle(
                                letterSpacing: .5,
                                fontSize: width / 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        popupmenu(),
                      ],
                    ),
                    Text(
                      'David Mansion',
                      style: GoogleFonts.ebGaramond(
                        textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: width / 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      '03:38 Min',
                      style: GoogleFonts.ebGaramond(
                        textStyle: TextStyle(
                            letterSpacing: .5,
                            fontSize: width / 25,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      children: [
                        Text(
                          'Playing Next- ',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                letterSpacing: .5,
                                fontSize: width / 25,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: width / 30,
                        ),
                        Text(
                          'Fi Hagat - Nancy Ajram',
                          style: GoogleFonts.ebGaramond(
                            textStyle: TextStyle(
                                letterSpacing: .5,
                                fontSize: width / 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // Slider(
                    //   //value: sliderValue,
                    //   min: 0,
                    //   max: 15,
                    //   value: 3,

                    //   //  max: duration.inSeconds.toDouble(),
                    //   // value: position.inSeconds.toDouble(),
                    //   activeColor: Colors.indigoAccent.shade700,
                    //   inactiveColor: Colors.indigo.shade200,
                    //   thumbColor: Colors.indigoAccent.shade700,
                    //   //divisions: 1,
                    //   //label: sliderValue.round().toString(),
                    //   onChanged: (double nvalue) async {
                    //     // setState(() {
                    //     //   sliderValue = nvalue.roundToDouble();
                    //     //},);
                    //   },
                    // )
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40.0,
                      ),
                      child: LinearPercentIndicator(
                        barRadius: const Radius.circular(15),
                        lineHeight: 5,
                        width: 360,
                        progressColor: Colors.deepPurple,
                        percent: 0.5,
                        animation: true,
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 5),
                      child: Text(
                        '00:00 ',
                        style: GoogleFonts.ebGaramond(
                          textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: width / 36,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      // color: Colors.greenAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.repeat_one_rounded,
                                color: Colors.deepPurpleAccent,
                                size: 40,
                              )),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.skip_previous_outlined,
                              color: Colors.deepPurpleAccent,
                              size: 44,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.play_circle_sharp,
                                color: Colors.deepPurpleAccent,
                                size: 44,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.skip_next_outlined,
                                color: Colors.deepPurpleAccent,
                                size: 44,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.shuffle_outlined,
                                color: Colors.deepPurpleAccent,
                                size: 40,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/arrowdown.png'),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
