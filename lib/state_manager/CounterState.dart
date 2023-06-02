import 'dart:async';

enum CounterAction { increament, decreament }

class CounterState {
  int _counter = 0;
  late bool unsigned;

  StreamController<CounterAction> _eventController =
      StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventController.sink;

  StreamController<int> _stateController = StreamController<int>();
  StreamSink<int> get _stateSink => _stateController.sink;
  Stream<int> get stateStream => _stateController.stream;

  void _mapEventToState(CounterAction counterAction) {
    if (counterAction == CounterAction.increament)
      _counter++;
    else
      _counter = _counter != 0 || unsigned ? --_counter : _counter;

    _stateSink.add(_counter);
  }

  CounterState({bool? unsigned}) {
    this.unsigned = unsigned ?? false;
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
