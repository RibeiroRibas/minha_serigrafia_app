abstract class RouteNavigator {
  Future<void> goTo(String routeName, {Map<String, dynamic>? arguments});
  Future<Object?> pushNamed(String routeName, {Map<String, dynamic>? arguments});
  void pop<T extends Object?>([T? result]);
}
