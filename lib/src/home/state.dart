class HomeState {
  int? selected;

  HomeState({this.selected = 0});

  HomeState copyWith({int? selected}) {
    return HomeState(selected: selected ?? this.selected);
  }
}
