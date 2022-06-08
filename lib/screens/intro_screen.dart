import 'package:flutter/material.dart';
import '../shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Globo Fitness')),
      bottomNavigationBar: MenuBottom(context),
      drawer: const MenuDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/BlackPanther.jpg'),
            fit: BoxFit.cover,
          )
        ),
              child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white70,
                    ),
                    child: const Text(
                        'Commit to be fit, there to be great, with Globo Fitness',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 22, 
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Colors.blueGrey,
                          ),
                        ]
                        )),
                  )),
            ));
  }


}