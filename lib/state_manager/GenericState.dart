
import 'dart:async';

class DataProviderState<T>{
  StreamController<T> _eventController = StreamController<T>();
  StreamSink<T> get eventSink => _eventController.sink;

  StreamController<T> _streamController = StreamController<T>();
  StreamSink<T> get _stateSink => _streamController.sink;
  Stream<T> get stream => _streamController.stream;

  void _mapDataToState(T t){
    _stateSink.add(t);
  }

  DataProviderState(){
    _eventController.stream.listen(_mapDataToState);
  }

  void dispose(){
    _eventController.close();
    _streamController.close();
  }
}