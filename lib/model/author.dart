class Author {
  String name;

  Author({required this.name});

  factory Author.createAuthor(Map<String, dynamic> object) {
    return Author(
      name: object["name"],
    );
  }
}
