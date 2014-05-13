// -*- mode:objc -*-

#import "AppColor.h"

@interface AppColor()

@end

@implementation AppColor

+ (UIColor *)tokenForegroundColor
{
  return [UIColor blackColor];
}

+ (UIColor *)tokenBackgroudColor
{
  static dispatch_once_t once;
  static UIColor *tokenBackgroudColor;
  dispatch_once(&once, ^{
      tokenBackgroudColor =
        [UIColor colorWithRed:240.0/255.0
                        green:248.0/255.0
                         blue:255.0/255.0
                        alpha:1.0];
    });
  return tokenBackgroudColor;
}

+ (UIColor *)tokenDelimiterColor
{
  static dispatch_once_t once;
  static UIColor *tokenDelimiterColor;
  dispatch_once(&once, ^{
      tokenDelimiterColor =
        [UIColor colorWithRed:0.0/255.0
                        green:122.0/255.0
                         blue:255.0/255.0
                        alpha:1.0];
    });
  return tokenDelimiterColor;
}

+ (UIColor *)lemmaDefaultColor
{
  return [UIColor blackColor];
}

+ (UIColor *)lemmaChangedColor
{
  static dispatch_once_t once;
  static UIColor *lemmaChangedColor;
  dispatch_once(&once, ^{
      lemmaChangedColor =
        [UIColor colorWithRed:255.0/255.0
                        green:45.0/255.0
                         blue:85.0/255.0
                        alpha:1.0];
    });
  return lemmaChangedColor;
}

+ (UIColor *)lexicalDefaultColor
{
  return [UIColor blackColor];
}

+ (UIColor *)lexicalNounColor
{
  static dispatch_once_t once;
  static UIColor *lexicalNounColor;
  dispatch_once(&once, ^{
      lexicalNounColor =
        [UIColor colorWithRed:253.0/255.0
                        green:48.0/255.0
                         blue:66.0/255.0
                        alpha:1.0];
    });
  return lexicalNounColor;
}

+ (UIColor *)lexicalVerbColor
{
  static dispatch_once_t once;
  static UIColor *lexicalVerbColor;
  dispatch_once(&once, ^{
      lexicalVerbColor =
        [UIColor colorWithRed:38.0/255.0
                        green:103.0/255.0
                         blue:238.0/255.0
                        alpha:1.0];
    });
  return lexicalVerbColor;
}

+ (UIColor *)lexicalAdjectiveColor
{
  static dispatch_once_t once;
  static UIColor *lexicalAdjectiveColor;
  dispatch_once(&once, ^{
      lexicalAdjectiveColor =
        [UIColor colorWithRed:36.0/255.0
                        green:210.0/255.0
                         blue:46.0/255.0
                        alpha:1.0];
    });
  return lexicalAdjectiveColor;
}

+ (UIColor *)lexicalAdverbColor
{
  static dispatch_once_t once;
  static UIColor *lexicalAdverbColor;
  dispatch_once(&once, ^{
      lexicalAdverbColor =
        [UIColor colorWithRed:89.0/255.0
                        green:90.0/255.0
                         blue:211.0/255.0
                        alpha:1.0];
    });
  return lexicalAdverbColor;
}

+ (UIColor *)lexicalPronounColor
{
  static dispatch_once_t once;
  static UIColor *lexicalPronounColor;
  dispatch_once(&once, ^{
      lexicalPronounColor =
        [UIColor colorWithRed:254.0/255.0
                        green:149.0/255.0
                         blue:39.0/255.0
                        alpha:1.0];
    });
  return lexicalPronounColor;
}

+ (UIColor *)lexicalDeterminerColor
{
  static dispatch_once_t once;
  static UIColor *lexicalDeterminerColor;
  dispatch_once(&once, ^{
      lexicalDeterminerColor =
        [UIColor colorWithRed:255.0/255.0
                        green:218.0/255.0
                         blue:89.0/255.0
                        alpha:1.0];
    });
  return lexicalDeterminerColor;
}

+ (UIColor *)lexicalParticleColor
{
  static dispatch_once_t once;
  static UIColor *lexicalParticleColor;
  dispatch_once(&once, ^{
      lexicalParticleColor =
        [UIColor colorWithRed:254.0/255.0
                        green:204.0/255.0
                         blue:48.0/255.0
                        alpha:1.0];
    });
  return lexicalParticleColor;
}

+ (UIColor *)lexicalPrepositionColor
{
  static dispatch_once_t once;
  static UIColor *lexicalPrepositionColor;
  dispatch_once(&once, ^{
      lexicalPrepositionColor =
        [UIColor colorWithRed:141.0/255.0
                        green:250.0/255.0
                         blue:120.0/255.0
                        alpha:1.0];
    });
  return lexicalPrepositionColor;
}

+ (UIColor *)lexicalNumberColor
{
  static dispatch_once_t once;
  static UIColor *lexicalNumberColor;
  dispatch_once(&once, ^{
      lexicalNumberColor =
        [UIColor colorWithRed:92.0/255.0
                        green:236.0/255.0
                         blue:199.0/255.0
                        alpha:1.0];
    });
  return lexicalNumberColor;
}

+ (UIColor *)lexicalConjunctionColor
{
  static dispatch_once_t once;
  static UIColor *lexicalNumberColor;
  dispatch_once(&once, ^{
      lexicalNumberColor =
        [UIColor colorWithRed:96.0/255.0
                        green:201.0/255.0
                         blue:249.0/255.0
                        alpha:1.0];
    });
  return lexicalNumberColor;
}

+ (UIColor *)lexicalInterjectionColor
{
  static dispatch_once_t once;
  static UIColor *lexicalInterjectionColor;
  dispatch_once(&once, ^{
      lexicalInterjectionColor =
        [UIColor colorWithRed:47.0/255.0
                        green:215.0/255.0
                         blue:251.0/255.0
                        alpha:1.0];
    });
  return lexicalInterjectionColor;
}

+ (UIColor *)lexicalClassifierColor
{
  static dispatch_once_t once;
  static UIColor *lexicalClassifierColor;
  dispatch_once(&once, ^{
      lexicalClassifierColor =
        [UIColor colorWithRed:198.0/255.0
                        green:78.0/255.0
                         blue:249.0/255.0
                        alpha:1.0];
    });
  return lexicalClassifierColor;
}

+ (UIColor *)lexicalIdiomColor
{
  static dispatch_once_t once;
  static UIColor *lexicalIdiomColor;
  dispatch_once(&once, ^{
      lexicalIdiomColor =
        [UIColor colorWithRed:252.0/255.0
                        green:95.0/255.0
                         blue:66.0/255.0
                        alpha:1.0];
    });
  return lexicalIdiomColor;
}

+ (UIColor *)lexicalOtherWordColor
{
  static dispatch_once_t once;
  static UIColor *lexicalOtherWordColor;
  dispatch_once(&once, ^{
      lexicalOtherWordColor =
        [UIColor colorWithRed:137.0/255.0
                        green:141.0/255.0
                         blue:145.0/255.0
                        alpha:1.0];
    });
  return lexicalOtherWordColor;
}

+ (UIColor *)nameDefaultColor
{
  return [UIColor blackColor];
}

+ (UIColor *)namePersonalColor
{
  static dispatch_once_t once;
  static UIColor *namePersonalColor;
  dispatch_once(&once, ^{
      namePersonalColor =
        [UIColor colorWithRed:76.0/255.0
                        green:217.0/255.0
                         blue:100.0/255.0
                        alpha:1.0];
    });
  return namePersonalColor;
}

+ (UIColor *)namePlaceColor
{
  static dispatch_once_t once;
  static UIColor *namePlaceColor;
  dispatch_once(&once, ^{
      namePlaceColor =
        [UIColor colorWithRed:255.0/255.0
                        green:149.0/255.0
                         blue:0.0/255.0
                        alpha:1.0];
    });
  return namePlaceColor;
}

+ (UIColor *)nameOrganizationColor
{
  static dispatch_once_t once;
  static UIColor *nameOrganizationColor;
  dispatch_once(&once, ^{
      nameOrganizationColor =
        [UIColor colorWithRed:88.0/255.0
                        green:86.0/255.0
                         blue:214.0/255.0
                        alpha:1.0];
    });
  return nameOrganizationColor;
}

@end

// EOF
