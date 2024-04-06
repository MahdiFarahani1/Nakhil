class NavModel {
  static int _index = 0;

  int get index => _index;

  changeState(int newIndex) {
    _index = newIndex;
  }
}
