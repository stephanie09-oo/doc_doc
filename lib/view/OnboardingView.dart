import 'package:doc_doc/units.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import '../customs/CustomElevatedButton.dart';
import '../routes/routes.dart';

class Onboardingview extends StatefulWidget {
  const Onboardingview({super.key});

  @override
  State<Onboardingview> createState() => _OnboardingviewState();
}

class _OnboardingviewState extends State<Onboardingview> {
  late PageController _controller;

  @override
  void initState(){
    _controller=PageController();
    super.initState();
  }

  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.only(top:Units.getHeight(context: context, widgetheight: 50)),
        child: Column(
          children: [
            Container(
                alignment: AlignmentDirectional.center,
                child: Text('Docdoc',style: TextStyle(fontWeight: FontWeight.bold
                ,fontSize: 33),)
            ),
            SizedBox(height: Units.getHeight(context: context, widgetheight: 5),),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset('assets/images/doctor.png',width: 400,),
                Container(
                  height: Units.getHeight(context: context, widgetheight: 60),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                           Colors.white,
                            Colors.white,
                            Colors.white.withAlpha(0),
                          ])
                  ),
                ),
                Center(
                  child: Text('     Best Doctor\n''Appointment App',
                    style:TextStyle(color: Colors.blue.shade500,
                        fontSize: 27,fontWeight: FontWeight.bold) ,),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Center(child: Text('Manage and schedule all of your medical appointments easily \n'
                '                 with Docdoc to get a new experience.',
              style: TextStyle(fontSize: 13,color: Colors.black54),)),
            SizedBox(height:  Units.getHeight(context: context, widgetheight: 5),),
            SizedBox(height:  Units.getHeight(context: context, widgetheight: 5),),
            Customelevatedbutton(buttonTitle: 'Get Started',textColor: Colors.white, btnColor:Colors.blue,onpressed: (){
              GoToNextPage();
            },),
          ],
        ),
      ),
    );
  }
  void GoToNextPage(){
    context.push(Routes.signup);
  }
}
