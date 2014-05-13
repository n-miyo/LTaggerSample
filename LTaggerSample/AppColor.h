// -*- mode:objc -*-

@import Foundation;

@interface AppColor: NSObject

+ (UIColor *)tokenForegroundColor;
+ (UIColor *)tokenBackgroudColor;
+ (UIColor *)tokenDelimiterColor;

+ (UIColor *)lemmaDefaultColor;
+ (UIColor *)lemmaChangedColor;

+ (UIColor *)lexicalDefaultColor;
+ (UIColor *)lexicalNounColor;
+ (UIColor *)lexicalVerbColor;
+ (UIColor *)lexicalAdjectiveColor;
+ (UIColor *)lexicalAdverbColor;
+ (UIColor *)lexicalPronounColor;
+ (UIColor *)lexicalDeterminerColor;
+ (UIColor *)lexicalParticleColor;
+ (UIColor *)lexicalPrepositionColor;
+ (UIColor *)lexicalNumberColor;
+ (UIColor *)lexicalConjunctionColor;
+ (UIColor *)lexicalInterjectionColor;
+ (UIColor *)lexicalClassifierColor;
+ (UIColor *)lexicalIdiomColor;
+ (UIColor *)lexicalOtherWordColor;

+ (UIColor *)nameDefaultColor;
+ (UIColor *)namePersonalColor;
+ (UIColor *)namePlaceColor;
+ (UIColor *)nameOrganizationColor;

@end

// EOF
