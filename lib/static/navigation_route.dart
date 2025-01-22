enum NavigationRoute {
  homeRoute('/'),
  detailRoute('/detail'),
  searchRoute('/search');

  const NavigationRoute(this.name);
  final String name;
}
