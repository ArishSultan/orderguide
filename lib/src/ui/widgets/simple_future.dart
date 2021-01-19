import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SimpleFutureDataBuilder<T> = Widget Function(BuildContext, T);
typedef SimpleFutureLoadingBuilder = Function(BuildContext, ConnectionState);
typedef SimpleFutureErrorBuilder = Widget Function(BuildContext, Object error);
class SimpleFutureBuilder<T> extends FutureBuilder<T> {
  SimpleFutureBuilder({
    Future<T> future,
    SimpleFutureDataBuilder<T> builder,
    SimpleFutureErrorBuilder errorBuilder,
    SimpleFutureLoadingBuilder loadingBuilder,
}): super(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('No Connection');
          case ConnectionState.waiting:
          case ConnectionState.active:
            if (loadingBuilder != null)
              return loadingBuilder(context, snapshot.connectionState);
            else return CircularProgressIndicator();
            break;
          case ConnectionState.done:
            return builder(context, snapshot.data);
          default:
            return Text('No Connection');
        }
      } else if (snapshot.hasError) {
        return errorBuilder(context, snapshot.error);
      } else {
        return Text('No Connection');
      }
    }
  );
}