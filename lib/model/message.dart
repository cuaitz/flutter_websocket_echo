enum MessageSource {
  sent, received
}

class Message {
  final String message;
  final MessageSource source;

  Message(this.message, this.source);
}
