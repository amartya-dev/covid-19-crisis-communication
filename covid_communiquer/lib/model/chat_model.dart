class Options {
  String label;
  String value;

  Options({this.label, this.value});
}

class Messages extends Options {
  String message;
  bool type;
  List<Options> options;

  Messages({this.message, this.type, this.options});
}
