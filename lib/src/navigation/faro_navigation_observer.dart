import 'package:faro_dart/faro_dart.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_faro/flutter_faro.dart';

const _navEventName = 'navigation';

typedef RouteNameExtractor = RouteSettings? Function(RouteSettings? settings);

typedef AdditionalInfoExtractor = Map<String, dynamic>? Function(
    RouteSettings? from,
    RouteSettings? to,
    );

class FaroNavigatorObserver extends RouteObserver<PageRoute<dynamic>> {
  Event? _transaction;

  FaroNavigatorObserver({
    RouteNameExtractor? routeNameExtractor,
    AdditionalInfoExtractor? additionalInfoProvider,
  })  :
        _routeNameExtractor = routeNameExtractor,
        _additionalInfoProvider = additionalInfoProvider;

  final RouteNameExtractor? _routeNameExtractor;
  final AdditionalInfoExtractor? _additionalInfoProvider;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    _setCurrentRoute(route);
    _addNavigationEvent(
      type: 'didPush',
      from: previousRoute?.settings,
      to: route.settings,
    );

    _finishTransaction();
    _startTransaction(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    _setCurrentRoute(newRoute);
    _addNavigationEvent(
      type: 'didReplace',
      from: oldRoute?.settings,
      to: newRoute?.settings,
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);

    _setCurrentRoute(previousRoute);
    _addNavigationEvent(
      type: 'didPop',
      from: route.settings,
      to: previousRoute?.settings,
    );

    _finishTransaction();
    _startTransaction(previousRoute);
  }

  void _addNavigationEvent({
    required String type,
    RouteSettings? from,
    RouteSettings? to,
  }) {
    final dynamic fromArgs = _formatArgs(from?.arguments);
    final dynamic toArgs = _formatArgs(to?.arguments);

    Map<String, String> attributes = {
      "type": type,
      "from": _routeNameExtractor?.call(from)?.toString() ?? from.toString(),
      "to": _routeNameExtractor?.call(to)?.toString() ?? to.toString(),

      if (from != null) 'from': from.name!,
      if (fromArgs != null) 'from_arguments': fromArgs,
      if (to != null) 'to': to.name!,
      if (toArgs != null) 'to_arguments': toArgs,
    };

    var dataAttributes = _additionalInfoProvider?.call(from, to);
    if (dataAttributes != null) {
      dataAttributes.forEach((key, value) {
        attributes['info_$key'] = value;
      });
    }
    
    FlutterFaro.pushEvent(_navEventName, attributes);
  }

  String? _getRouteName(Route<dynamic>? route) {
    return (_routeNameExtractor?.call(route?.settings) ?? route?.settings)
        ?.name;
  }

  Future<void> _setCurrentRoute(Route<dynamic>? route) async {
    final name = _getRouteName(route);
    if (name == null) {
      return;
    }
  }

  Future<void> _startTransaction(Route<dynamic>? route) async {
    String? name = _getRouteName(route);
    final arguments = route?.settings.arguments;

    if (name == null) {
      return;
    }

    if (name == '/') {
      name = 'root ("/")';
    }

    _transaction = Event(_navEventName, attributes: {
      'name': name,
    });

    if (arguments != null) {
      _transaction?.attributes['route_settings_arguments'] = arguments;
    }
  }

  Future<void> _finishTransaction() async {
    if (_transaction != null) {
      FlutterFaro.pushEvent(_transaction!.name, _transaction!.attributes);
    }
  }

  static dynamic _formatArgs(Object? args) {
    if (args == null) {
      return null;
    }
    if (args is Map<String, dynamic>) {
      return args.map<String, dynamic>((key, dynamic value) =>
          MapEntry<String, String>(key, value.toString()));
    }
    return args.toString();
  }
}