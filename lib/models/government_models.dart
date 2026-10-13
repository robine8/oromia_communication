class RegionalSector {
  final int id;
  final String name;
  final String description;
  final String? contactPhone;
  final String? contactEmail;
  final String? officeAddress;

  RegionalSector({
    required this.id,
    required this.name,
    required this.description,
    this.contactPhone,
    this.contactEmail,
    this.officeAddress,
  });

  factory RegionalSector.fromJson(Map<String, dynamic> json) {
    return RegionalSector(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      contactPhone: json['contact_phone'],
      contactEmail: json['contact_email'],
      officeAddress: json['office_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'contact_phone': contactPhone,
      'contact_email': contactEmail,
      'office_address': officeAddress,
    };
  }
}

class GovRegion {
  final int id;
  final String name;
  final String type; // 'zone' | 'woreda' | 'city' | 'sub_city' | 'kebele'
  final int? parentId;
  final String? contactInfo;
  final int childCount;
  final String? parentName; // For breadcrumb display

  GovRegion({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
    this.contactInfo,
    this.childCount = 0,
    this.parentName,
  });

  bool get isLeaf => type == 'kebele';

  String get typeDisplayName {
    switch (type) {
      case 'zone':
        return 'Zone';
      case 'woreda':
        return 'Woreda';
      case 'city':
        return 'City';
      case 'sub_city':
        return 'Sub-City';
      case 'kebele':
        return 'Kebele';
      default:
        return type;
    }
  }

  String get childTypeDisplayName {
    switch (type) {
      case 'zone':
        return 'Woredas';
      case 'woreda':
        return 'Kebeles';
      case 'city':
        return 'Sub-Cities';
      case 'sub_city':
        return 'Kebeles';
      default:
        return '';
    }
  }

  factory GovRegion.fromJson(Map<String, dynamic> json) {
    return GovRegion(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? 'zone',
      parentId: json['parent_id'],
      contactInfo: json['contact_info'],
      childCount: json['child_count'] ?? 0,
      parentName: json['parent_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'parent_id': parentId,
      'contact_info': contactInfo,
      'child_count': childCount,
      'parent_name': parentName,
    };
  }
}

// Mock data generator for development
class GovernmentMockData {
  static List<RegionalSector> getRegionalSectors() {
    return [
      RegionalSector(
        id: 1,
        name: 'Oromia Health Bureau',
        description: 'Responsible for public health services, hospitals, and health centers across Oromia region.',
        contactPhone: '+251 115 541 816',
        contactEmail: 'info@health.oromia.gov.et',
        officeAddress: 'Bole Dembel, Finfinnee (Addis Ababa)',
      ),
      RegionalSector(
        id: 2,
        name: 'Oromia Education Bureau',
        description: 'Oversees primary, secondary, and higher education institutions in Oromia region.',
        contactPhone: '+251 115 541 817',
        contactEmail: 'info@education.oromia.gov.et',
        officeAddress: 'Bole Dembel, Finfinnee (Addis Ababa)',
      ),
      RegionalSector(
        id: 3,
        name: 'Oromia Agriculture Bureau',
        description: 'Promotes agricultural development, food security, and rural transformation.',
        contactPhone: '+251 115 541 818',
        contactEmail: 'info@agriculture.oromia.gov.et',
        officeAddress: 'Bole Dembel, Finfinnee (Addis Ababa)',
      ),
      RegionalSector(
        id: 4,
        name: 'Oromia Communication Bureau',
        description: 'Manages public communication, media relations, and information dissemination.',
        contactPhone: '+251 115 541 801',
        contactEmail: 'info@oromiacommunication.gov.et',
        officeAddress: 'Bole Dembel, Finfinnee (Addis Ababa)',
      ),
      RegionalSector(
        id: 5,
        name: 'Oromia Water and Energy Bureau',
        description: 'Responsible for water resource management and energy infrastructure development.',
        contactPhone: '+251 115 541 819',
        contactEmail: 'info@water.oromia.gov.et',
        officeAddress: 'Bole Dembel, Finfinnee (Addis Ababa)',
      ),
    ];
  }

  static List<GovRegion> getZones() {
    return [
      GovRegion(id: 1, name: 'Arsi Zone', type: 'zone', childCount: 12),
      GovRegion(id: 2, name: 'Bale Zone', type: 'zone', childCount: 8),
      GovRegion(id: 3, name: 'Borena Zone', type: 'zone', childCount: 10),
      GovRegion(id: 4, name: 'East Hararghe Zone', type: 'zone', childCount: 15),
      GovRegion(id: 5, name: 'East Shewa Zone', type: 'zone', childCount: 14),
      GovRegion(id: 6, name: 'Guji Zone', type: 'zone', childCount: 9),
      GovRegion(id: 7, name: 'Illubabor Zone', type: 'zone', childCount: 11),
      GovRegion(id: 8, name: 'Jimma Zone', type: 'zone', childCount: 13),
      GovRegion(id: 9, name: 'Kelem Wollega Zone', type: 'zone', childCount: 7),
      GovRegion(id: 10, name: 'North Shewa Zone', type: 'zone', childCount: 12),
      GovRegion(id: 11, name: 'Southwest Shewa Zone', type: 'zone', childCount: 10),
      GovRegion(id: 12, name: 'West Arsi Zone', type: 'zone', childCount: 9),
    ];
  }

  static List<GovRegion> getWoredas(int zoneId) {
    final mockWoredas = {
      1: ['Dodota', 'Jeju', 'Merti', 'Sire', 'Tiyo', 'Ziway'],
      2: ['Adaba', 'Delo Menna', 'Ginnir', 'Goba'],
      3: ['Arero', 'Dirre', 'Gelana', 'Gomole', 'Teltele'],
      4: ['Babile', 'Deder', 'Fedis', 'Gursum', 'Haromaya', 'Kersa'],
      5: ['Adama', 'Akaki', 'Bishoftu', 'Dukem', 'Mojo', 'Segen'],
      6: ['Bore', 'Dima', 'Guji', 'Harena', 'Mega'],
      7: ['Algie', 'Didessa', 'Gore', 'Haro', 'Yayu'],
      8: ['Dedo', 'Gomma', 'Gura', 'Kersa', 'Limu', 'Mana', 'Sekoru'],
      9: ['Gidami', 'Hawa', 'Homa', 'Leka', 'Zembi'],
      10: ['Abichuna', 'Alem Tena', 'Debre Berhan', 'Fiche', 'Ginchi'],
      11: ['Ambo', 'Bako', 'Ginchi', 'Guder', 'Ilfata', 'Jibat'],
      12: ['Batu', 'Dodota', 'Limu', 'Shashamane', 'Siraro'],
    };

    final names = mockWoredas[zoneId] ?? ['Woreda 1', 'Woreda 2', 'Woreda 3'];
    return names.map((name) => GovRegion(
      id: names.indexOf(name) + 1,
      name: name,
      type: 'woreda',
      parentId: zoneId,
      childCount: (name.hashCode % 8) + 3,
    )).toList();
  }

  static List<GovRegion> getCities() {
    return [
      GovRegion(id: 1, name: 'Adama', type: 'city', childCount: 5),
      GovRegion(id: 2, name: 'Jimma', type: 'city', childCount: 4),
      GovRegion(id: 3, name: 'Bishoftu', type: 'city', childCount: 3),
      GovRegion(id: 4, name: 'Shashamane', type: 'city', childCount: 4),
      GovRegion(id: 5, name: 'Ambo', type: 'city', childCount: 3),
    ];
  }

  static List<GovRegion> getSubCities(int cityId) {
    final mockSubCities = {
      1: ['Adama Ketema', 'Bole', 'Ginfle', 'Kebele 01', 'Kebele 02'],
      2: ['Jimma Ketema', 'Mendi', 'Hirmata', 'Seka'],
      3: ['Bishoftu Ketema', 'Kebele 01', 'Kebele 02'],
      4: ['Shashamane Ketema', 'Kebele 01', 'Kebele 02', 'Kebele 03'],
      5: ['Ambo Ketema', 'Kebele 01', 'Kebele 02'],
    };

    final names = mockSubCities[cityId] ?? ['Sub-City 1', 'Sub-City 2'];
    return names.map((name) => GovRegion(
      id: names.indexOf(name) + 1,
      name: name,
      type: 'sub_city',
      parentId: cityId,
      childCount: (name.hashCode % 5) + 2,
    )).toList();
  }

  static List<GovRegion> getKebeles(int parentId, String parentType) {
    final mockKebeles = [
      'Kebele 01', 'Kebele 02', 'Kebele 03', 'Kebele 04', 'Kebele 05',
      'Kebele 06', 'Kebele 07', 'Kebele 08', 'Kebele 09', 'Kebele 10',
    ];
    final count = (parentId.hashCode % 6) + 4;
    return mockKebeles.take(count).map((name) => GovRegion(
      id: mockKebeles.indexOf(name) + 1,
      name: name,
      type: 'kebele',
      parentId: parentId,
      childCount: 0,
      contactInfo: 'Contact: +251 9${parentId}${mockKebeles.indexOf(name)}${mockKebeles.indexOf(name)}',
    )).toList();
  }
}