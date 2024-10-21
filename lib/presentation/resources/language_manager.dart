enum LanguageType {
  ENGLISH,
  VIETNAM,
}

const String VIETNAM = "vi";
const String ENGLISH = "en";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.VIETNAM:
        return VIETNAM;
    }
  }
}
