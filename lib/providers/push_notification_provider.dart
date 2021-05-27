
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider{

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications(){
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token){

      print ('==== FCM Token =====');
      print(token);

      //fPf8fADnTsWwrXWALpZXyw:APA91bHY1O144s5yxwatE7Z80-GbhAARmB97fK0TfzFilMBbvQmC3uY4_UN-oFqE_G88U8hFM2DcYclKTnp2k5XcNAGXIx3SP8XkQHcoL-FGPi_YZmatfM5ZMWfzlJ0MyllyKjeXo9-d
    });
    FirebaseMessaging.onMessage.listen((message) {
      print('====== On Mensage ======');
      print('¡Recibí un mensaje mientras estaba en primer plano!');
      print('Datos del mensaje: ${message.data}');

      if (message.notification != null) {
        print('El mensaje tambien contenia una notificacion: ${message.notification}');
      }
      String argumento = 'no-data';
      if (Platform.isAndroid){
        argumento = message.data['comida'] ?? 'no-data';

      }
      _mensajesStreamController.sink.add(message.notification.body);
      
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('====== On Resume ======');
      print('¡Recibí un mensaje mientras estaba en segundo plano!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('El mensaje tambien contenia una notificacion: ${message.notification}');
      }
      final noti = message.data['comida'];
      //print (noti);
      _mensajesStreamController.sink.add(message.notification.body);
      
    });





  }

  dispose(){
    _mensajesStreamController?.close();
  }
  


}