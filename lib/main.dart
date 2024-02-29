import 'dart:async';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool power = false;
  int ms=0, sec=0, min=0;

  Color bgColor = const Color(0xff1b1f27);
  Color light = Colors.tealAccent;

  Color buttonColor = const Color(0xff1b1f27);
  Color buttonIconColor = Colors.blueGrey;

  Color timerIconColor = Colors.blueGrey;
  Color timerShadowColor = const Color(0xff1b1f27);

  Color playBtnIconColor = Colors.blueGrey;
  Color playBtnShadowColor = const Color(0xff1b1f27);

  bool play=true;
  Icon icn = const Icon(Icons.play_arrow);

  Color textColor = Colors.blueGrey;

  late Timer timer;
  late Column column;

  List<String> lapData = [];

  int lapCount = 0;

  ScrollController scrollController = ScrollController();

  Color lapIconColor = Colors.blueGrey;
  Color lapTextColor = Colors.blueGrey;

  String strMs="00", strSec="00", strMin="00";

  IconData arrow = Icons.arrow_forward_ios;
  bool colorRowVis = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b1f27),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: bgColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          if(colorRowVis==false){
                            colorRowVis=true;
                            arrow = Icons.arrow_back_ios;
                            setState(() {

                            });
                          }else if(colorRowVis==true){
                            colorRowVis=false;
                            arrow = Icons.arrow_forward_ios;
                            setState(() {

                            });
                          }
                        },
                        child: Icon(arrow, size: 23, color: Colors.blueGrey,)),
                    const SizedBox(width: 6,),
                    Visibility(
                      visible:  colorRowVis,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Select Activate Color", style: TextStyle(color: Colors.blueGrey),),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: (){
                                    light = Colors.tealAccent;
                                    if(power==true){
                                     textColor = light;
                                    buttonColor = light;
                                    buttonIconColor = light;
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: CircleAvatar(radius: 15, backgroundColor: Colors.tealAccent,)),
                              const SizedBox(width: 10,),
                              InkWell(
                                  onTap: (){
                                    light = Colors.blue;
                                    if(power==true){
                                     textColor = light;
                                    buttonColor = light;
                                    buttonIconColor = light;
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: CircleAvatar(radius: 15, backgroundColor: Colors.blue,)),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                    light = Colors.teal;
                                    if(power==true){
                                     textColor = light;
                                    buttonColor = light;
                                    buttonIconColor = light;
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: CircleAvatar(radius: 15, backgroundColor: Colors.teal,)),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                    light = Colors.lightGreenAccent;
                                    if(power==true){
                                     textColor = light;
                                    buttonColor = light;
                                    buttonIconColor = light;
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: CircleAvatar(radius: 15, backgroundColor: Colors.lightGreenAccent,)),
                              const SizedBox(width: 10,),
                              InkWell(
                                onTap: (){
                                    light = Colors.orange;
                                    if(power==true){
                                     textColor = light;
                                    buttonColor = light;
                                    buttonIconColor = light;
                                    }
                                    setState(() {

                                    });
                                  },
                                  child: CircleAvatar(radius: 15, backgroundColor: Colors.orange,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                stopWatch(),
                const Center(child: Text("long press power button to clear lap list", style: TextStyle(fontSize: 12, color: Colors.blueGrey),)),
                const SizedBox(height: 10,),
                actionButtons(),
                const SizedBox(height: 10,),
                Expanded(child: lapTimer()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stopWatch(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 350,
        width: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            border: Border.all(
              color: Colors.black12,
              width: 0,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: 350,
            width: 350,
            decoration: BoxDecoration(
                color: bgColor,
                boxShadow: [
                  BoxShadow(
                      color: buttonColor,
                      spreadRadius: 9,
                      blurRadius: 10
                  )
                ],
                borderRadius: BorderRadius.circular(200),
                border: Border.all(
                  color: Colors.black12,
                  width: 5,
                )
            ),
            child: Center(child: Text("$strMin:$strSec:$strMs", style: TextStyle(fontSize: 45, color: textColor),)),
          ),
        ),
      ),
    );//main container
  }

  Widget actionButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){

            if(power==true){
              timerShadowColor = light;
              timerIconColor = light;
              Timer(const Duration(milliseconds: 100), () {
                timerShadowColor = const Color(0xff1b1f27);
                timerIconColor = Colors.blueGrey;
                setState(() {

                });
              });

              lapCount++;
              lapData.add("Lap $lapCount -- -- $strMin:$strSec:$strMs");
              lapTextColor = light;
              lapIconColor = light;
              Timer(const Duration(milliseconds: 100), () {
                lapIconColor = Colors.blueGrey;
                lapTextColor = Colors.blueGrey;
                setState(() {

                });
              });
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            }else{
              timerShadowColor = Colors.red;
              timerIconColor = Colors.red;
              Timer(const Duration(milliseconds: 100), () {
                timerShadowColor = const Color(0xff1b1f27);
                timerIconColor = Colors.blueGrey;
                setState(() {

                });
              });
            }



            setState(() {

            });
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: timerShadowColor,
                          spreadRadius: 9,
                          blurRadius: 10
                      )
                    ],
                    color: bgColor,
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Colors.black12,
                      width: 5,
                    )
                ),
                child: Center(child: Icon(Icons.more_time_rounded, color: timerIconColor, size: 50,)),
              ),
            ),
          ),
        ),// Lap Button
        const SizedBox(width: 30,),
        GestureDetector(
          onLongPress: (){
            buttonColor = Colors.red;
            buttonIconColor = Colors.red;
            if(power==true){
              Timer(const Duration(milliseconds: 100), () {
                buttonColor = light;
                buttonIconColor = light;
                setState(() {

                });
              });
            }else{
              Timer(const Duration(milliseconds: 100), () {
                buttonColor = const Color(0xff1b1f27);
                buttonIconColor = Colors.blueGrey;
                setState(() {

                });
              });
            }


            lapCount=0;
            lapData.clear();
            setState(() {

            });
          },
          onTap: (){
            light=light;
            setState(() {

            });
            power=!power;
            if(power==true){
              textColor = light;
              buttonColor = light;
              buttonIconColor = light;
              startTimer();
              play=false;
              icn = const Icon(Icons.pause);
            }else{
              textColor = Colors.blueGrey;
              buttonColor = const Color(0xff1b1f27);
              buttonIconColor = Colors.blueGrey;
              ms=0; sec=0; min=0;
              strMs="00"; strSec="00"; strMin="00";
              cancelTimer();
              play = true;
              icn = const Icon(Icons.play_arrow);
            }
            setState(() {

            });

          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: bgColor,
                    boxShadow: [
                      BoxShadow(
                          color: buttonColor,
                          spreadRadius: 9,
                          blurRadius: 10
                      )
                    ],
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Colors.black12,
                      width: 5,
                    )
                ),
                child: Center(child: Icon(Icons.power_settings_new, color: buttonIconColor, size: 50,)),
              ),
            ),
          ),
        ),// Power Button
        const SizedBox(width: 30,),
        InkWell(
          onTap: (){
            if(power==true){
              playBtnShadowColor = light;
              playBtnIconColor = light;
              Timer(const Duration(milliseconds: 100), () {
                playBtnShadowColor = const Color(0xff1b1f27);
                playBtnIconColor = Colors.blueGrey;
                setState(() {

                });
              });

              if(power==true && play==false){
                cancelTimer();
                play=true;
                icn = const Icon(Icons.play_arrow);
              }else if(power==true && play==true){
                startTimer();
                play=false;
                icn = const Icon(Icons.pause);
              }
            }
            else if(power==false){
              playBtnShadowColor = Colors.red;
              playBtnIconColor = Colors.red;
              Timer(const Duration(milliseconds: 100), () {
                playBtnShadowColor = const Color(0xff1b1f27);
                playBtnIconColor = Colors.blueGrey;
                setState(() {});
              });
            }

            setState(() {

            });
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: playBtnShadowColor,
                          spreadRadius: 9,
                          blurRadius: 10
                      )
                    ],
                    color: bgColor,
                    borderRadius: BorderRadius.circular(200),
                    border: Border.all(
                      color: Colors.black12,
                      width: 5,
                    )
                ),
                child: Center(child: Icon(icn.icon, color: playBtnIconColor, size: 50,)),
              ),
            ),
          ),
        ),// play/pause button
      ],
    );
  }
  
  Widget lapTimer(){
    return ListView(
        controller: scrollController,
        children: lapData.map((data){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.more_time, color: lapIconColor, size: 25,),
                  const SizedBox(width: 20,),
                  Text(data, style: TextStyle(color: lapTextColor)),
                ],
              ),
            ),
          );
        }).toList()
    );
  }

  void startTimer(){
    timer = Timer.periodic(const Duration(milliseconds: 8), (timer) {
      ms++;
      if(ms<=9){
        strMs = "0$ms";
      }else{
        strMs = "$ms";
      }
      setState(() {});

      if(ms>99){
        sec++;
        ms=0;
        if(ms<=9){
          strMs = "0$ms";
        }else{
          strMs = "$ms";
        }
        if(sec<=9){
          strSec = "0$sec";
        }else{
          strSec = "$sec";
        }
        setState(() {});

        if(sec>59){
          min++;
          sec=0;
          ms=0;
          if(ms<=9){
            strMs = "0$ms";
          }else{
            strMs = "$ms";
          }
          if(sec<=9){
            strSec = "0$sec";
          }else{
            strSec = "$sec";
          }
          if(min<=9){
            strMin = "0$min";
          }else{
            strMin = "$min";
          }
          setState(() {});

        }
      }
    });
  }

  void cancelTimer(){
    timer.cancel();
  }

}