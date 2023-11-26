class JobPost {
  final String name;
  final String company;
  final List<String> techniques;
  final String location;
  final String career;
  final String link;
  final String recruitmentSite;

  JobPost({
    required this.name,
    required this.company,
    required this.techniques,
    required this.location,
    required this.career,
    required this.link,
    required this.recruitmentSite,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      name: json['name'] as String? ?? 'N/A',
      company: json['company'] as String? ?? 'N/A',
      techniques:
      (json['techniques'] as List?)?.map((e) => e as String).toList() ?? [],
      location: json['location'] as String? ?? 'N/A',
      career: json['career'] as String? ?? 'N/A',
      link: json['link'] as String? ?? 'N/A',
      recruitmentSite: json['recruitmentSite'] as String? ?? 'N/A',
    );
  }
}