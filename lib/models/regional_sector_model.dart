class RegionalSector {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String? website;
  final List<Contact>? contacts;

  RegionalSector({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    this.website,
    this.contacts,
  });

  factory RegionalSector.fromJson(Map<String, dynamic> json) {
    return RegionalSector(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? json['image'],
      website: json['website'],
      contacts: json['contacts'] != null
          ? (json['contacts'] as List).map((c) => Contact.fromJson(c)).toList()
          : null,
    );
  }
}

class Contact {
  final String type;
  final String value;
  final String? label;

  Contact({required this.type, required this.value, this.label});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      type: json['type'] ?? '',
      value: json['value'] ?? '',
      label: json['label'],
    );
  }
}
