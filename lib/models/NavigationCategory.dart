enum NavigationCategory {
  none(tabIndex: -1, url: 'login'),

  home(tabIndex: 0, title: "Home", svgIcon: "src/icons/home.svg", url: 'home'),
  map(tabIndex: 1, title: "Map", svgIcon: "src/icons/map.svg", url: 'map'),
  account(tabIndex: 2, title: "Account", svgIcon: "src/icons/account.svg", url: 'account');

  const NavigationCategory({
    required this.tabIndex,
    this.title = '',
    this.svgIcon = '',
    this.url = '',
  });

  final int tabIndex;
  final String title;
  final String svgIcon;
  final String url;

  static final List<NavigationCategory> all = <NavigationCategory>[
    NavigationCategory.home,
    NavigationCategory.map,
    NavigationCategory.account
  ];
}
