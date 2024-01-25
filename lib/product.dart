class Product {
  String title;
  String price;
  String more;
  String category;
  String image;
  String ratingValue;
  int ratingCount;

  Product(
      {required this.category,
      required this.image,
      required this.more,
      required this.price,
      required this.ratingCount,
      required this.ratingValue,
      required this.title});

  factory Product.fromJson(var data) {
    return Product(
        category: data["category"],
        image: data["image"],
        more: data["description"],
        price: data["price"].toString(),
        ratingCount: data["rating"]["count"],
        ratingValue: data["rating"]["rate"].toString(),
        title: data["title"]);
  }
}
