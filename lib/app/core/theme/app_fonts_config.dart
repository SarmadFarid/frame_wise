class FontFamily {
  //fonts
  static const String dmSans = 'DMSans';
  static const String inter = 'Inter';
  static const String roboto = 'Roboto';

}

enum AppFontFamily {
  dmSans,
  inter,
  roboto,
}

class AppFontsConfig {
  AppFontsConfig._();  
  
  static AppFontFamily current  = AppFontFamily.dmSans ; 

  static String get family {
    switch(current) {
       case AppFontFamily.inter : 
       return 'Inter' ; 
       case AppFontFamily.roboto : 
       return 'Roboto' ; 
       case AppFontFamily.dmSans : 
       return 'DMSans' ; 
    }
  }
 
}
