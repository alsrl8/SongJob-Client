class AddToFavoritesRequest {
  final String link;

  AddToFavoritesRequest({required this.link});

  factory AddToFavoritesRequest.fromJson(Map<String, dynamic> json) {
    return AddToFavoritesRequest(
      link: json['link'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'link': link,
    };
  }
}

class RemoveFromFavoriteRequest {
  final String link;

  RemoveFromFavoriteRequest({required this.link});

  factory RemoveFromFavoriteRequest.fromJson(Map<String, dynamic> json) {
    return RemoveFromFavoriteRequest(
      link: json['link'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'link': link,
    };
  }
}
