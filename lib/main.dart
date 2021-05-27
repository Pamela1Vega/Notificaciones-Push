import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:push_local/pages/mensaje_page.dart';
import 'package:push_local/providers/push_notification_provider.dart';

import 'package:push_local/pages/home_page.dart'; 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState()=> _MyAppState();
       
}
class _MyAppState extends State<MyApp>{

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();
    pushProvider.mensajes.listen((data){

      //Navigator.pushNamed(context, routeName)
      print('Argumento del Psuh');
      print(data);

      navigatorKey.currentState.pushNamed('mensaje',arguments: data);
    });
    

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Push Local',
      initialRoute: 'home',
      routes: {
        'home' : (BuildContext contex) => HomePage(),
        'mensaje' : (BuildContext contex) => MensajePage(),
      } 
    );
  }
 
}