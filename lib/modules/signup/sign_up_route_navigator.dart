import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/shared/routes/route_navigator.dart';

class SignUpRouteNavigator extends RouteNavigator {
  @override
  Future<void> goTo(String routeName, {Map<String, dynamic>? arguments}) async {
    Modular.to.navigate(routeName, arguments: arguments);
  }

  @override
  Future<Object?> pushNamed(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) async {
    return await Modular.to.pushNamed(routeName, arguments: arguments);
  }

  @override
  void pop<T extends Object?>([T? result]) {
    Modular.to.pop(result);
  }
}
