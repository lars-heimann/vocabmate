enum TargetLanguage {
  english,
  mandarin,
  hindi,
  spanish,
  french,
  arabic,
  bengali,
  russian,
  portuguese,
  urdu,
  indonesian,
  german,
  japanese,
  marathi,
  telugu,
  turkish,
  tamil,
  vietnamese,
  korean,
  italian;

  String getUIText() {
    switch (this) {
      case TargetLanguage.english:
        return 'English';
      case TargetLanguage.mandarin:
        return 'Mandarin';
      case TargetLanguage.hindi:
        return 'Hindi';
      case TargetLanguage.spanish:
        return 'Spanish';
      case TargetLanguage.french:
        return 'French';
      case TargetLanguage.arabic:
        return 'Arabic';
      case TargetLanguage.bengali:
        return 'Bengali';
      case TargetLanguage.russian:
        return 'Russian';
      case TargetLanguage.portuguese:
        return 'Portuguese';
      case TargetLanguage.urdu:
        return 'Urdu';
      case TargetLanguage.indonesian:
        return 'Indonesian';
      case TargetLanguage.german:
        return 'German';
      case TargetLanguage.japanese:
        return 'Japanese';
      case TargetLanguage.marathi:
        return 'Marathi';
      case TargetLanguage.telugu:
        return 'Telugu';
      case TargetLanguage.turkish:
        return 'Turkish';
      case TargetLanguage.tamil:
        return 'Tamil';
      case TargetLanguage.vietnamese:
        return 'Vietnamese';
      case TargetLanguage.korean:
        return 'Korean';
      case TargetLanguage.italian:
        return 'Italian';
    }
  }
}
