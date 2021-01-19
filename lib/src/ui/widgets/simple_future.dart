import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef UnknownStateBuilder<T> = Widget Function(BuildContext);
typedef SimpleFutureDataBuilder<T> = Widget Function(BuildContext, T);
typedef SimpleFutureLoadingBuilder = Function(BuildContext, ConnectionState);
typedef SimpleFutureErrorBuilder = Widget Function(BuildContext, Object error);

class SimpleFutureBuilder<T> extends FutureBuilder<T> {
  SimpleFutureBuilder({
    Future<T> future,
    UnknownStateBuilder unknownBuilder,
    SimpleFutureDataBuilder<T> builder,
    SimpleFutureErrorBuilder errorBuilder,
    SimpleFutureLoadingBuilder loadingBuilder,
}): super(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            if (loadingBuilder != null)
              return loadingBuilder(context, snapshot.connectionState);
            return CircularProgressIndicator();
          case ConnectionState.done:
            return builder(context, snapshot.data);
          case ConnectionState.none:
          default:
            if (unknownBuilder != null) return unknownBuilder(context);
            return Text('No Connection');
        }
      } else if (snapshot.hasError) {
        if (errorBuilder != null) return errorBuilder(context, snapshot.error);
        return Text(snapshot.error.toString());
      } else {
        if (unknownBuilder != null) return unknownBuilder(context);
        return Text('No Connection');
      }
    }
  );
}