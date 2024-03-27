class SearchModel {
  bool _isSearchMode = false;

  bool get isSearchMode => _isSearchMode;

  changeState() {
    _isSearchMode = !_isSearchMode;
  }
}
