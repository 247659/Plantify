import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'pl'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? plText = '',
  }) =>
      [enText, plText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // SignUpPage
  {
    'cxnavteq': {
      'en': 'Plant',
      'pl': 'Plant',
    },
    'ezpdoy7z': {
      'en': 'ify',
      'pl': 'ify',
    },
    'j55uf4ib': {
      'en': 'Create an account',
      'pl': 'Utwórz konto',
    },
    '1kdh1ewv': {
      'en': 'Let\'s get started by filling out the form below.',
      'pl': 'Zacznijmy od wypełnienia poniższego formularza.',
    },
    '9l95ptjc': {
      'en': ' E-mail',
      'pl': 'E-mail',
    },
    'b868ems7': {
      'en': ' E-mail is required',
      'pl': 'E-mail jest wymagany',
    },
    '6yzg1wt0': {
      'en': 'This is not correct e-mail',
      'pl': 'To nie jest poprawy e-mail',
    },
    'bygk10rx': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
    'kyinlqp4': {
      'en': 'Username',
      'pl': 'Nazwa użytkownika',
    },
    'x67cj0u7': {
      'en': 'Username is required',
      'pl': 'Nazwa użytkownika jest wymagana',
    },
    '8ta15n6l': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    'wylseyub': {
      'en': ' Password',
      'pl': 'Hasło',
    },
    '8opk733x': {
      'en': ' Password is required',
      'pl': 'Hasło jest wymagane',
    },
    '334revf2': {
      'en': 'Password should have at least 6 characters',
      'pl': 'Hasło powinno mieć przynajmniej 6 znaków',
    },
    '0hf5wzth': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
    '0ff6qpce': {
      'en': ' Confirm Password',
      'pl': 'Potwierdź hasło',
    },
    'yk43n53b': {
      'en': 'Passwords are not the same',
      'pl': 'Hasła nie są takie same',
    },
    'rgldye1r': {
      'en': 'Create Account',
      'pl': 'Utwórz konto',
    },
    'fi6enl5t': {
      'en': 'OR',
      'pl': 'LUB',
    },
    'xzj3bcsx': {
      'en': 'Continue with Google',
      'pl': 'Kontynuuj z Google',
    },
    '0bu2zqal': {
      'en': 'Already have an account? ',
      'pl': 'Masz już konto?',
    },
    'mgwhob35': {
      'en': ' Sign In here',
      'pl': 'Zaloguj się tutaj',
    },
    '6mm84iv5': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // Splash
  {
    'oxsudr0x': {
      'en': 'Change language',
      'pl': 'Zmień język',
    },
    'tvfleoi5': {
      'en': 'Polski',
      'pl': 'English',
    },
    'sh05yta9': {
      'en': 'Plant',
      'pl': 'Plant',
    },
    'cs177hoa': {
      'en': 'ify',
      'pl': 'ify',
    },
    'y85759zm': {
      'en': 'Get Started',
      'pl': 'Rozpocznij',
    },
    '2jy9gos6': {
      'en': 'Already a member?  ',
      'pl': 'Jesteś już członkiem?',
    },
    '1df45tl7': {
      'en': 'Sign In',
      'pl': 'Zaloguj się',
    },
    'lruzg5l3': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // Profile
  {
    'y3pcvvbc': {
      'en': 'Hello,',
      'pl': 'Cześć,',
    },
    'n2ycghrs': {
      'en': 'Thank you for supporting us!',
      'pl': 'Dziękujemy za wsparcie!',
    },
    'j9meukp9': {
      'en':
          'As a local business, we thank you for supporting us and hope you enjoy.',
      'pl':
          'Jako lokalna firma dziękujemy za wsparcie i mamy nadzieję, że Państwu się spodoba.',
    },
    'f7o7ytac': {
      'en': 'Edit Profile',
      'pl': 'Edytuj profil',
    },
    'wbewocpi': {
      'en': 'About Us',
      'pl': 'O nas',
    },
    'nc0f4to4': {
      'en': 'Settings',
      'pl': 'Ustawienia',
    },
    '6roihswp': {
      'en': 'Log out',
      'pl': 'Wyloguj się',
    },
    '40zuzkeo': {
      'en': 'Profile',
      'pl': 'Profil',
    },
  },
  // Dashboard
  {
    'c03mc318': {
      'en': 'Yours plants',
      'pl': 'Twoje rośliny',
    },
    '6tsiq3u6': {
      'en': 'Take care of your own plants.',
      'pl': 'Dbaj o swoje rośliny.',
    },
    'kcsjfxgk': {
      'en': 'Filters',
      'pl': 'Filtry',
    },
    '57tjzgux': {
      'en': 'Option 1',
      'pl': 'Opcja 1',
    },
    'kcsallmk': {
      'en': 'Option 2',
      'pl': 'Opcja 2',
    },
    'wz6patjv': {
      'en': 'Option 3',
      'pl': 'Opcja 3',
    },
    '396dyfdf': {
      'en': 'Plants',
      'pl': 'Rośliny',
    },
  },
  // Onboarding_Slideshow
  {
    'pc4a7h7a': {
      'en': 'Local, Customized Plant Curation',
      'pl': 'Lokalna, dostosowana do potrzeb uprawa roślin',
    },
    'fkmh8onv': {
      'en':
          'Create your own personalized plant collection from our variety of beautiful and easy-to-care-for plants.',
      'pl':
          'Stwórz własną, spersonalizowaną kolekcję roślin spośród naszego bogatego asortymentu pięknych i łatwych w pielęgnacji roślin.',
    },
    'cpgwy2e0': {
      'en': 'Never Forget to Water Your Plants Again',
      'pl': 'Nigdy więcej nie zapomnij podlać swoich roślin',
    },
    'y786y016': {
      'en':
          'Our app helps you take care of your plants by reminding you when to water them, ensuring they stay healthy and thrive.',
      'pl':
          'Nasza aplikacja pomaga dbać o rośliny, przypominając, kiedy należy je podlewać, dzięki czemu pozostają zdrowe i rosną.',
    },
    '403w9uod': {
      'en': 'Personalized Plant Care at Your Fingertips',
      'pl': 'Spersonalizowana pielęgnacja roślin na wyciągnięcie ręki',
    },
    'aoq85fxs': {
      'en':
          'Our app keeps your plants happy and healthy by providing personalized watering schedules and care tips tailored to each plant’s needs.',
      'pl':
          'Nasza aplikacja dba o zdrowie i dobre samopoczucie Twoich roślin, oferując spersonalizowane harmonogramy podlewania i porady pielęgnacyjne dostosowane do potrzeb każdej rośliny.',
    },
    'xptodxy9': {
      'en': 'Continue',
      'pl': 'Dalej',
    },
    'te9quezk': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // AboutAs
  {
    'sle98gzl': {
      'en': 'About Us',
      'pl': 'O nas',
    },
    '3slzx7j5': {
      'en': 'Students of Lodz University of Technology',
      'pl': 'Studenci Politechniki Łódzkiej',
    },
    'ikubjlol': {
      'en': 'Company Name',
      'pl': 'Nazwa firmy',
    },
    '6qiubm3a': {
      'en': 'Plantify Corporation',
      'pl': 'Plantify Corporation',
    },
    'cfvnifo1': {
      'en': 'Our Chef',
      'pl': 'Nasz Szef Kuchni',
    },
    '6dqsdl6g': {
      'en': 'Wiktor Żelechowski',
      'pl': 'Wiktor Żelechowski',
    },
    'y5v7jt3m': {
      'en': 'Team Leader',
      'pl': 'Lider zespołu',
    },
    'yni01v97': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // CreatePlant
  {
    'd75b5e08': {
      'en': 'Add your plant',
      'pl': 'Dodaj swoją roślinę',
    },
    'b3hdsfrk': {
      'en': 'Recognize',
      'pl': 'Rozpoznaj',
    },
    'juril70h': {
      'en': 'Error during recognizing',
      'pl': 'Błąd podczas rozpoznawania',
    },
    'j5z87w4i': {
      'en': ' Recognize by photo',
      'pl': 'Rozpoznaj po zdjęciu',
    },
    'pyzse80q': {
      'en': ' Auto',
      'pl': 'Automatycznie',
    },
    'z91dcghu': {
      'en': 'Search...',
      'pl': 'Szukaj...',
    },
    'gk9ze7v7': {
      'en': ' Auto',
      'pl': 'Automatycznie',
    },
    'wft7naln': {
      'en': ' Leaf',
      'pl': 'Liść',
    },
    'ymu5d0x9': {
      'en': ' Flower',
      'pl': 'Kwiat',
    },
    's2c7iii5': {
      'en': ' Fruit',
      'pl': 'Owoc',
    },
    'i8wattxy': {
      'en': ' Bark',
      'pl': 'Kora',
    },
    'qyemrcp4': {
      'en': ' Select category',
      'pl': 'Wybierz kategorię',
    },
    'jybivrsu': {
      'en': 'Search...',
      'pl': 'Szukaj...',
    },
    '8s1y4jwl': {
      'en': ' Name',
      'pl': 'Nazwa',
    },
    '2mjj6v5w': {
      'en': ' Name is required',
      'pl': 'Nazwa jest wymagane',
    },
    'pfisx4ns': {
      'en': '',
      'pl': '',
    },
    '3ut1bj9o': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
    '9tojj8ou': {
      'en': ' Description',
      'pl': 'Opis',
    },
    'bvmtbeoh': {
      'en': ' Location',
      'pl': 'Lokalizacja',
    },
    'b7bvwup8': {
      'en': ' Species',
      'pl': 'Gatunek',
    },
    'hm8f05yr': {
      'en': ' Species is required',
      'pl': 'Gatunek jest wymagany ',
    },
    '4cl22xb7': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
    'sn9k8c7p': {
      'en': 'Add',
      'pl': 'Dodaj',
    },
    '94075mlo': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // GuidePage
  {
    'a6e30llq': {
      'en': 'Guide',
      'pl': 'Poradnik',
    },
    'jdfjasls': {
      'en': 'Start looking for the species',
      'pl': 'Zacznij szukać roślin',
    },
    '3db37zup': {
      'en': 'Plant name',
      'pl': 'Nazwa rośliny',
    },
    '74nagpv3': {
      'en': ' Name is required',
      'pl': 'Nazwa jest wymagane',
    },
    'saj2s2uu': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
    '05nml1rg': {
      'en': 'Find',
      'pl': 'Szukaj',
    },
    '16lao7ef': {
      'en': 'Plants list',
      'pl': 'Lista roślin',
    },
    'hupxmhby': {
      'en': 'FAQ',
      'pl': 'FAQ',
    },
    '1izhef13': {
      'en': 'Plants list',
      'pl': 'Lista roślin',
    },
    'wsc7h7ok': {
      'en': 'Show details',
      'pl': 'Pokaż szczegóły',
    },
    'aob4qb0j': {
      'en': 'Loading...',
      'pl': 'Wczytywanie...',
    },
    '8ewgeup8': {
      'en': 'Start looking for plants',
      'pl': 'Zacznij szukanie roślin',
    },
    'oa2msbjv': {
      'en': 'Chatbot',
      'pl': 'Czatbot',
    },
    'mdqrer0b': {
      'en': 'Guide',
      'pl': 'Poradnik',
    },
  },
  // EditProfile
  {
    '4gj5zb4m': {
      'en': 'Edit Profile',
      'pl': 'Edytuj profil',
    },
    'wlnktl72': {
      'en': 'Full Name',
      'pl': 'Pełne imię i nazwisko',
    },
    's88dfupi': {
      'en': '',
      'pl': '',
    },
    'tjjm95g9': {
      'en': '',
      'pl': '',
    },
    '4rgah9nx': {
      'en': 'Reset Password',
      'pl': 'Zresetuj hasło',
    },
    'xtv1fy5o': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // Settings
  {
    'udd8jjcn': {
      'en': 'Settings',
      'pl': 'Ustawienia',
    },
    'tpjzi5ox': {
      'en': 'Mode',
      'pl': 'Motyw',
    },
    'b5oqrrdl': {
      'en': 'Dark',
      'pl': 'Ciemny',
    },
    '0d3ltod8': {
      'en': 'Light',
      'pl': 'Jasny',
    },
    '6ytw5hbn': {
      'en': 'Auto',
      'pl': 'Auto',
    },
    'cueuzs0t': {
      'en': 'Language',
      'pl': 'Język',
    },
    'hvzinxuj': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // SinglePlantGuidePage
  {
    'xofqccha': {
      'en': 'About',
      'pl': 'O roślinie',
    },
    '9wxbqbbv': {
      'en': 'Overview',
      'pl': 'Przegląd',
    },
    'lwijlu6j': {
      'en': 'Care',
      'pl': 'Pielęgnacja',
    },
    'g75ks4si': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // ShoppingList
  {
    'amcoh1fd': {
      'en': 'Shopping List',
      'pl': 'Lista zakupów',
    },
    '3msc126y': {
      'en': 'Shopping list for taking good care of your plants',
      'pl': 'Lista zakupów, która pomoże Ci zadbać o rośliny',
    },
    '49frn1i3': {
      'en': 'List',
      'pl': 'Lista',
    },
  },
  // ItemList
  {
    'ttcg2qnk': {
      'en': 'Item list',
      'pl': 'Lista przedmiotów',
    },
    '5zk10ove': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // Calendar
  {
    '85lr7nct': {
      'en': 'Calendar',
      'pl': 'Kalendarz',
    },
    'o3myty9g': {
      'en': 'Manage the care time of your plants',
      'pl': 'Zarządzaj czasem opieki nad swoimi roślinami',
    },
    'vlpgg1qs': {
      'en': 'Calendar',
      'pl': 'Kalendarz',
    },
  },
  // LoginPage
  {
    'l4yw9n74': {
      'en': 'Plant',
      'pl': 'Plant',
    },
    '6132zwj2': {
      'en': 'ify',
      'pl': 'ify',
    },
    'w567baah': {
      'en': 'Welcome Back',
      'pl': 'Witamy ponownie',
    },
    '811387c1': {
      'en': ' Email',
      'pl': 'E-mail',
    },
    'oxl1v0d9': {
      'en': ' Password',
      'pl': 'Hasło',
    },
    'r56pp7y2': {
      'en': 'Sign In',
      'pl': 'Zaloguj się',
    },
    'vthpkbz0': {
      'en': 'OR',
      'pl': 'LUB',
    },
    '6ghuz9xt': {
      'en': 'Continue with Google',
      'pl': 'Kontynuuj z Google',
    },
    'zdowj31j': {
      'en': 'Don\'t have an account? ',
      'pl': 'Nie masz konta?',
    },
    'oy2rko1m': {
      'en': 'Sign Up here',
      'pl': 'Zarejestruj się tutaj',
    },
    'u7w47eon': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // PlantDetails
  {
    'afcscwhn': {
      'en': 'Overview',
      'pl': 'Informacje',
    },
    'j3jm3flt': {
      'en': 'Description',
      'pl': 'Opis',
    },
    's0n9788x': {
      'en': 'Species',
      'pl': 'Gatunek',
    },
    'il7szhfz': {
      'en': 'Location',
      'pl': 'Lokalizacja',
    },
    'hacvi8kj': {
      'en': 'Category',
      'pl': 'Kategoria',
    },
    'qa89t5sj': {
      'en': 'Owner',
      'pl': 'Właściciel',
    },
    'b0u7fag8': {
      'en': 'Care Tips',
      'pl': 'Wskazówki pielęgnacyjne',
    },
    'zh077lx2': {
      'en': 'No care tips',
      'pl': 'Brak wskazówek dotyczących pielęgnacji',
    },
    'lweur9mm': {
      'en': 'Get care tips by plant species',
      'pl': 'Znajdź wskazówki na podstawie gatunku rośliny',
    },
    'aw8gceni': {
      'en': 'Find',
      'pl': 'Szukaj',
    },
    'b215dmit': {
      'en': 'Cannot find tips for this species.',
      'pl': 'Nie można znaleźć wskazówek dla tego gatunku.',
    },
    '71dbsv5v': {
      'en': 'Calendar',
      'pl': 'Kalendarz',
    },
    '6c4q8x7w': {
      'en': 'Shopping list',
      'pl': 'Lista zakupów',
    },
    'i09fz593': {
      'en': 'Error during recognizing',
      'pl': 'Błąd podczas rozpoznawania',
    },
    'klr5t2gg': {
      'en': 'Name',
      'pl': 'Nazwa',
    },
    'lnaw0u3q': {
      'en': '',
      'pl': '',
    },
    'yoaux3uv': {
      'en': 'Name',
      'pl': 'Nazwa',
    },
    '4h1qr8eo': {
      'en': 'Name is required',
      'pl': 'Nazwa jest wymagana',
    },
    't40wundu': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    'tbnql0b4': {
      'en': 'Description',
      'pl': 'Opis',
    },
    'wl00296x': {
      'en': '',
      'pl': '',
    },
    'icwvp74h': {
      'en': 'Description',
      'pl': 'Opis',
    },
    'bq3t7ln8': {
      'en': 'Species',
      'pl': 'Gatunek',
    },
    'jt3uupr3': {
      'en': 'Species',
      'pl': 'Gatunek',
    },
    're45y0yh': {
      'en': 'Species is required',
      'pl': 'Gatunek jest wymagany',
    },
    'emcunutd': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    'uusqlpmx': {
      'en': 'Location',
      'pl': 'Lokalizacja',
    },
    'wksap8vl': {
      'en': 'Location',
      'pl': 'Lokalizacja',
    },
    'cz16n7mq': {
      'en': 'Category',
      'pl': 'Kategoria',
    },
    'scvl49oc': {
      'en': 'Category',
      'pl': 'Kategoria',
    },
    '3wkwqk0a': {
      'en': 'Search...',
      'pl': 'Szukaj...',
    },
    'ug06lfp9': {
      'en': 'Option 1',
      'pl': 'Opcja 1',
    },
    'wsjbzlbh': {
      'en': 'Option 2',
      'pl': 'Opcja 2',
    },
    'bqvy6qmv': {
      'en': 'Option 3',
      'pl': 'Opcja 3',
    },
    '8m8g5ii2': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // chatPage
  {
    '1tvpjpv5': {
      'en': 'Chatbot',
      'pl': 'Czatbot',
    },
    '9t0sex1z': {
      'en': 'Type something...',
      'pl': 'Zacznij pisać...',
    },
    '1mqhrrwy': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // AddCalendar
  {
    'iqdmu5xa': {
      'en': 'Add event',
      'pl': 'Dodaj wydarzenie',
    },
    'uqpurzvb': {
      'en': 'Single',
      'pl': 'Jednorazowe',
    },
    'coz8guzp': {
      'en': 'Periodic',
      'pl': 'Okresowe',
    },
    'x22sywlb': {
      'en': 'Single',
      'pl': 'Jednorazowe',
    },
    'fcvvc36r': {
      'en': ' Select period',
      'pl': 'Wybierz kategorię',
    },
    '9bwy0jcl': {
      'en': 'Search...',
      'pl': 'Szukaj...',
    },
    'eklxq6no': {
      'en': 'Event name',
      'pl': 'Nazwa wydarzenia',
    },
    'f4e447i2': {
      'en': 'Date',
      'pl': '',
    },
    'z9outtgs': {
      'en': 'Date',
      'pl': '',
    },
    '8r8s0bdy': {
      'en': 'Event name is required',
      'pl': 'Nazwa wydarzenia jest wymagana',
    },
    '8ta15n6l': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    '723b0us0': {
      'en': 'Date is required',
      'pl': 'Data jest wymagana',
    },
    '2wn6nqgw': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    'azbo6ich': {
      'en': 'Add',
      'pl': 'Dodaj',
    },
    'dz9xfzdw': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // ChangeCalendar
  {
    'lsz5r0o2': {
      'en': 'Edit event',
      'pl': 'Edytuj wydarzenie',
    },
    'tq12glae': {
      'en': 'Event name',
      'pl': 'Nazwa wydarzenia',
    },
    'ooh4plgn': {
      'en': 'Date',
      'pl': '',
    },
    'plzc3v5b': {
      'en': 'Date',
      'pl': '',
    },
    '7qh9vvr9': {
      'en': 'Event name is required',
      'pl': 'Nazwa wydarzenia jest wymagana',
    },
    'mk7q9aij': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
    'u7uhy69b': {
      'en': 'Date is required',
      'pl': 'Data jest wymagana',
    },
    'twpzu3f2': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    'cdrb3n6v': {
      'en': 'Delete periodic events',
      'pl': 'Usuń okresowe wydarzenia',
    },
    'bsdpbcrw': {
      'en': 'Change',
      'pl': 'Zmień',
    },
    'fuh8r1oq': {
      'en': 'Home',
      'pl': 'Dom',
    },
  },
  // inviteFriend
  {
    'proyyu1l': {
      'en': 'Invite your friend',
      'pl': 'Zaproś swojego znajomego',
    },
    'opaisk9l': {
      'en': 'Type username below',
      'pl': 'Wpisz poniżej nazwę użytkownika',
    },
    'wfrwj9tb': {
      'en': 'Enter friend\'s username',
      'pl': 'Wprowadź nazwę użytkownika znajomego',
    },
    '83u4je8j': {
      'en': 'Invite',
      'pl': 'Zaproś',
    },
    '69166cpi': {
      'en': 'Members',
      'pl': 'Członkowie',
    },
  },
  // shoppingListCardLoading
  {
    'bwoh7atm': {
      'en': 'A',
      'pl': 'A',
    },
    'ekp3uyxq': {
      'en': 'List Item',
      'pl': 'Element listy',
    },
  },
  // PlantOverviewComponent
  {
    'mq7menkc': {
      'en': 'Basic Info',
      'pl': 'Informacje podstawowe',
    },
    'jci7bo8a': {
      'en': 'Origin',
      'pl': 'Pochodzenie',
    },
    'ze81wtu0': {
      'en': 'Cycle',
      'pl': 'Cykl',
    },
    '9wjp6mg3': {
      'en': 'Type',
      'pl': 'Typ',
    },
    'ogkel2tj': {
      'en': 'Toxicity to Humans',
      'pl': 'Toksyczność dla ludzi',
    },
    'i0a186ks': {
      'en': 'Toxicity to Pets',
      'pl': 'Toksyczność dla zwierząt domowych',
    },
    '34gtvp5i': {
      'en': 'Fruits',
      'pl': 'Owoce',
    },
    'fos42ta4': {
      'en': 'Flowers',
      'pl': 'Kwiaty',
    },
    'vrrz21u0': {
      'en': 'Medicial',
      'pl': 'Medyczne',
    },
    'c7oqbje6': {
      'en': 'Edible',
      'pl': 'Jadalny',
    },
    'jos98snr': {
      'en': 'Care level',
      'pl': 'Poziom opieki',
    },
    'un0uuqor': {
      'en': 'Plant Anatomy',
      'pl': 'Anatomia roślin',
    },
  },
  // PlantCareComponent
  {
    'hr5849m3': {
      'en': 'Care Instructions',
      'pl': 'Instrukcje pielęgnacji',
    },
    'mmg71rjv': {
      'en': 'Watering ',
      'pl': 'Nawadnianie',
    },
    'qhuy2l6j': {
      'en': 'Sunlight',
      'pl': 'Nasłonecznienie',
    },
    'pm5pm411': {
      'en': 'Pruning',
      'pl': 'Przycinanie',
    },
  },
  // addItemComponent
  {
    '5dy72mae': {
      'en': 'Item name',
      'pl': 'Nazwa przedmiotu',
    },
    'fygupuko': {
      'en': 'Item name',
      'pl': 'Nazwa elementu',
    },
    'g3xdvw79': {
      'en': 'Add',
      'pl': 'Dodać',
    },
    'zmwi4l8n': {
      'en': 'Item name is required',
      'pl': 'Nazwa elementu jest wymagana',
    },
    'b0neg14v': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
  },
  // shoppingListComponent
  {
    '91dyiuhs': {
      'en': 'No item in list',
      'pl': 'Brak pozycji na liście',
    },
    '4c7te6hy': {
      'en': 'Add item ',
      'pl': 'Dodaj element',
    },
  },
  // addListComponent
  {
    'dd2fx18v': {
      'en': 'Specific list',
      'pl': 'Lista dla kwiatka',
    },
    'neh75pta': {
      'en': 'General list',
      'pl': 'Lista ogólna',
    },
    'hlel0u2j': {
      'en': 'Shopping list name',
      'pl': 'Nazwa listy zakupów',
    },
    'rk6y17eu': {
      'en': 'Shopping list name',
      'pl': 'Nazwa listy zakupów',
    },
    '84f2ob1q': {
      'en': 'Shopping list name is required',
      'pl': 'Nazwa listy zakupów jest wymagana',
    },
    '4bpogcp7': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    's83p6bxw': {
      'en': 'Plant',
      'pl': 'Roślina',
    },
    'wv35hilu': {
      'en': 'Select plant',
      'pl': 'Wybierz roślinę',
    },
    '08rvn7bz': {
      'en': 'Search',
      'pl': 'Szukaj',
    },
    'vnq96vg5': {
      'en': 'Option 1',
      'pl': 'Opcja 1',
    },
    'nn87xgpj': {
      'en': 'Option 2',
      'pl': 'Opcja 2',
    },
    '954ko5to': {
      'en': 'Option 3',
      'pl': 'Opcja 3',
    },
    'u2gpqeet': {
      'en': 'Add',
      'pl': 'Dodaj',
    },
    'q9g5af3a': {
      'en': 'Generate list',
      'pl': 'Wygeneruj listę',
    },
  },
  // generatedList
  {
    'y33xk68y': {
      'en': 'Add',
      'pl': 'Dodaj',
    },
    '8fb5nxsp': {
      'en': 'Generating failed',
      'pl': 'Generowanie nie powiodło się',
    },
  },
  // changeItemComponent
  {
    'jrmhvy58': {
      'en': 'Change item name',
      'pl': 'Zmień nazwę elementu',
    },
    'kf1w06kt': {
      'en': 'Item name',
      'pl': 'Nazwa elementu',
    },
    'j28fg0vj': {
      'en': 'Item name is required',
      'pl': 'Nazwa elementu jest wymagana',
    },
    'vaun8jz9': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    'rqpm62wx': {
      'en': 'Change',
      'pl': 'Zmiana',
    },
  },
  // changeListComponent
  {
    '5vmjn0ne': {
      'en': 'Change list name',
      'pl': 'Zmień nazwę listy',
    },
    'wx9guss5': {
      'en': 'List name',
      'pl': 'Nazwa listy',
    },
    'l4x322et': {
      'en': 'List name is required',
      'pl': 'Nazwa listy jest wymagana',
    },
    'ku02iivr': {
      'en': 'Please choose an option from the dropdown',
      'pl': '',
    },
    '2fakialz': {
      'en': 'Change',
      'pl': 'Zmiana',
    },
  },
  // listComponent
  {
    'diocmshi': {
      'en': 'No shopping list',
      'pl': 'Brak listy zakupów',
    },
    '9kwhqs4t': {
      'en': 'Add your first shopping list',
      'pl': 'Dodaj swoją pierwszą listę zakupów',
    },
  },
  // listPlantComponent
  {
    'prdld6ho': {
      'en': 'No shopping list',
      'pl': 'Brak listy zakupów',
    },
    '3gg2k9uo': {
      'en': 'Add your first shopping list',
      'pl': 'Dodaj swoją pierwszą listę zakupów',
    },
  },
  // plantSettingsComponent
  {
    'kh5phkc5': {
      'en': 'Manage the plant',
      'pl': 'Zarządzaj rośliną',
    },
  },
  // plantCalendar
  {
    'ht8m2vcu': {
      'en': 'Coming',
      'pl': 'Nadchodzące',
    },
    'q5br2vdx': {
      'en': 'Archival',
      'pl': 'Archiwalne',
    },
    't51lavwf': {
      'en': 'Coming',
      'pl': 'Nadchodzące',
    },
    '0fk3zbyf': {
      'en': 'No actual events',
      'pl': 'Brak aktualnych wydarzeń',
    },
    'qo27vubp': {
      'en': 'Add yours events',
      'pl': 'Dodaj swoje wydarzenia',
    },
    'v3kzuu3y': {
      'en': 'No archival events',
      'pl': 'Brak wydarzeń archiwalnych',
    },
    'itx5xlzw': {
      'en': 'Add yours events',
      'pl': 'Dodaj swoje wydarzenia',
    },
  },
  // plantCalendarBin
  {
    'q20lw22i': {
      'en': ' - ',
      'pl': ' - ',
    },
  },
  // addListPlantComponent
  {
    'dr0giyt7': {
      'en': 'Shopping list name',
      'pl': 'Nazwa listy zakupów',
    },
    '5bq9d94y': {
      'en': 'Shopping list name',
      'pl': 'Nazwa listy zakupów',
    },
    'd4djsxtx': {
      'en': 'Shopping list name is required',
      'pl': 'Nazwa listy zakupów jest wymagana',
    },
    'je4wj3iu': {
      'en': 'Please choose an option from the dropdown',
      'pl': 'Proszę, wybierz opcję z listy',
    },
    'nr025g0e': {
      'en': 'Add',
      'pl': 'Dodaj',
    },
    '9r1wkw6c': {
      'en': 'Generate list',
      'pl': 'Wygeneruj listę',
    },
  },
  // plantCalendarDay
  {
    'c3m6ksxh': {
      'en': 'No event this day',
      'pl': 'Brak wydarzeń w tym dniu',
    },
    'socp423w': {
      'en': 'Add some events',
      'pl': 'Dodaj jakieś wydarzenia',
    },
  },
  // plantCalendarBinDay
  {
    '5q6q7c8v': {
      'en': ' - ',
      'pl': ' - ',
    },
  },
  // Miscellaneous
  {
    'x3n1m54w': {
      'en': '',
      'pl': '',
    },
    '00rm8931': {
      'en': '',
      'pl': '',
    },
    'ddvp56vr': {
      'en': 'Needed for push notifications',
      'pl': '',
    },
    'isu02i08': {
      'en': '',
      'pl': '',
    },
    'wxqi0yvk': {
      'en': '',
      'pl': '',
    },
    'jn35vsvd': {
      'en': '',
      'pl': '',
    },
    '77qou35i': {
      'en': '',
      'pl': '',
    },
    'wtdd05f6': {
      'en': '',
      'pl': '',
    },
    'g1d0pk7y': {
      'en': '',
      'pl': '',
    },
    'p672tm54': {
      'en': '',
      'pl': '',
    },
    'q0sipvit': {
      'en': '',
      'pl': '',
    },
    'kgb5kld2': {
      'en': '',
      'pl': '',
    },
    'c7uljd76': {
      'en': '',
      'pl': '',
    },
    'li57vnst': {
      'en': '',
      'pl': '',
    },
    'p073aili': {
      'en': '',
      'pl': '',
    },
    '5y1epgqd': {
      'en': '',
      'pl': '',
    },
    'gw4e6k0f': {
      'en': '',
      'pl': '',
    },
    'dx9tuaw1': {
      'en': '',
      'pl': '',
    },
    '68u75yxt': {
      'en': '',
      'pl': '',
    },
    '3hz14ck1': {
      'en': '',
      'pl': '',
    },
    'gkrzti2v': {
      'en': '',
      'pl': '',
    },
    'cr8xa2x7': {
      'en': '',
      'pl': '',
    },
    'h76kh87r': {
      'en': '',
      'pl': '',
    },
    'q7vjdsbv': {
      'en': '',
      'pl': '',
    },
    'l96q161o': {
      'en': '',
      'pl': '',
    },
    '8dhj92e1': {
      'en': '',
      'pl': '',
    },
    'puluqv2o': {
      'en': '',
      'pl': '',
    },
    'ery5nfzj': {
      'en': '',
      'pl': '',
    },
  },
].reduce((a, b) => a..addAll(b));
