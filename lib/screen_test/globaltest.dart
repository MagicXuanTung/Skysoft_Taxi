import 'dart:async';

import 'package:web_socket_channel/io.dart';

late IOWebSocketChannel channel;
IOWebSocketChannel? channelWS;
StreamSubscription<dynamic>? subscription;
