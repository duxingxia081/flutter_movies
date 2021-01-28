class DataUtils {
  static httpToHttps(final url) {
    return url?.replaceFirst(RegExp("http"), "https");
  }
}
