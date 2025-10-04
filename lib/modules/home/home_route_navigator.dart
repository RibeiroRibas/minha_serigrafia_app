import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/shared/routes/route_navigator.dart';

class HomeRouteNavigator extends RouteNavigator {
  @override
  Future<void> goTo(String routeName, {Map<String, dynamic>? arguments}) async {
    Modular.to.navigate(routeName, arguments: arguments);
  }

  @override
  Future<void> pushNamed(
    String routeName, {
    Map<String, dynamic>? arguments,
  }) async {
    await Modular.to.pushNamed(routeName, arguments: arguments);
  }

  @override
  Future<void> pop() async {
    Modular.to.pop();
  }
}
