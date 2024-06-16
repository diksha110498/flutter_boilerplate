class User {
  final int ?id;
  final String? name;
  final String ?imageUrl;
  final bool ?isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Nick Fury',
  imageUrl: 'images/nextdaydelivery.png',
  isOnline: true,
);
