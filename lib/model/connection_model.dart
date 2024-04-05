import 'package:flutter/material.dart';
import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConnectionModel extends ChangeNotifier {
  late final PublicChannel _channel;

  ConnectionModel() {
    connect();
  }

  void connect() async {
    final hostOptions = PusherChannelsOptions.fromCluster(
      scheme: 'wss',
      cluster: 'sa1',
      key: dotenv.env['API_KEY']!
    );

    final client = PusherChannelsClient.websocket(
        options: hostOptions,
        connectionErrorHandler: (exception, trace, refresh) async {
            print(exception);
            refresh();
        });
    
    _channel = client.publicChannel('my-channel');

    client.onConnectionEstablished.listen((_) {
        _channel.subscribeIfNotUnsubscribed();
    });

    client.connect();
  }

  void setEventCallback(String eventName, void Function(ChannelReadEvent event) callback) {
    _channel.bind(eventName).listen(callback);
  }
}