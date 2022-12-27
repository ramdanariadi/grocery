import 'dart:async';

class BoolState{
  
  StreamController<bool> _eventController = StreamController<bool>();
  StreamSink<bool> get eventSink => _eventController.sink;

  StreamController<bool> _stateController = StreamController<bool>();
  StreamSink<bool> get _stateSink => _stateController.sink;
  Stream<bool> get stateStream => _stateController.stream;

  void _mapEventToState(bool state){
    _stateSink.add(state);
  }

  BoolState(){
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose(){
    _eventController.close();
    _stateController.close();
  }
}