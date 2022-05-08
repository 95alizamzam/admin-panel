class Package {
  String? id;
  String? packageName;
  int? expires;
  dynamic price;
  int? products;
  int? posts;
  int? videos;
  int? images;
  int? chatInDays;
  int? storyInDays;
  int? storyCount;

  Package({
    required this.id,
    required this.packageName,
    required this.chatInDays,
    required this.expires,
    required this.images,
    required this.posts,
    required this.price,
    required this.products,
    required this.storyInDays,
    required this.videos,
    required this.storyCount,
  });

  Package.fromMap(Map<String, dynamic> map, String pId) {
    id = pId;
    packageName = map['packageName'];
    chatInDays = map['chatInDays'];
    expires = map['expires'];
    images = map['images'];
    posts = map['posts'];
    price = map['price'];
    products = map['products'];
    storyInDays = map['storyInDays'];
    videos = map['videos'];
    storyCount = map['storyCount'];
  }

  Map<String, dynamic> toMap() => {
    'packageName': packageName,
    'chatInDays': chatInDays,
    'expires': expires,
    'images': images,
    'posts': posts,
    'price': price,
    'products': products,
    'storyInDays': storyInDays,
    'videos': videos,
    'storyCount': storyCount,
  };
}
