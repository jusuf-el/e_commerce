class Endpoints {
  static const String baseUrl = 'https://fakestoreapi.com/';

  static const String productCategories = 'products/categories';
  static const String products = 'products';
  static const String productsByCategory = 'products/category/';
  static const String photos = 'photos';

  static String setUrlParameters(List<Map<String, dynamic>> parameters) {
    String urlParameters = '';

    for (var element in parameters) {
      if (element['value'] != null) {
        if (urlParameters.isEmpty) {
          urlParameters =
          '$urlParameters?${element['key']}=${element['value']}';
        } else {
          urlParameters =
          '$urlParameters&${element['key']}=${element['value']}';
        }
      }
    }

    return urlParameters;
  }
}