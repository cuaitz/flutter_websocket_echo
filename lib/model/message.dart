enum MessageSource {
  sent, received
}

class Message {
  final String message;
  final MessageSource source;
  final DateTime date;

  Message(this.message, this.source, this.date);
}
