class Post {
  String animalName;
  String location;
  String description;
  String imageUrl;
  String userId;
  Timestamp createdAt;

  Post(this.animalName, this.location, this.description, this.imageUrl,
      this.userId, this.createdAt);

  static toMap(Post post) {
    return {
      'animalName': post.animalName,
      'location': post.location,
      'description': post.description,
      'imageUrl': post.imageUrl,
      'userId': post.userId,
      'createdAt': post.createdAt,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
        map['animalName'], map['location'], map['description'], map['imageUrl'],
        map['userId'], map['createdAt']);
  }
}
