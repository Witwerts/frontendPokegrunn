enum NavigationCategory {
  none(),

  home(title: "Home", svgIcon: "src/icons/home.svg", url: '/'),
  search(title: "Search", svgIcon: "src/icons/search.svg", url: '/qrscan'),
  map(title: "Map", svgIcon: "src/icons/map.svg", url: '/map'),
  account(title: "Account", svgIcon: "src/icons/account.svg", url: '/account');

  const NavigationCategory({
    this.title = '',
    this.svgIcon = '',
    this.url = '',
  });

  final String title;
  final String svgIcon;
  final String url;

  static final List<NavigationCategory> all = <NavigationCategory>[
    NavigationCategory.home,
    NavigationCategory.search,
    NavigationCategory.map,
    NavigationCategory.account
  ];
}
