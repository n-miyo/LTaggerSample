// -*- mode:objc -*-

#import "Tagger.h"

#import "AppColor.h"

@interface Tagger()

@property (nonatomic) NSArray *schemes;

@end

@implementation Tagger

#pragma mark - Life Cycle

- (instancetype)initWithLanguage:(NSString *)language
{
  self = [super init];
  if (self) {
    _string = @"";
    _schemes = [NSLinguisticTagger availableTagSchemesForLanguage:language];
  }

  return self;
}

#pragma mark - Public

- (NSArray *)availableTagSchemes
{
  return self.schemes;
}

- (NSAttributedString *)analyzeWithTokenType
{
  if ([self.schemes indexOfObject:NSLinguisticTagSchemeTokenType]
      == NSNotFound) {
    return [[NSAttributedString alloc] initWithString:self.string];
  }

  NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
  NSLinguisticTagger *t =
    [[NSLinguisticTagger alloc]
      initWithTagSchemes:@[NSLinguisticTagSchemeTokenType]
                 options:0];
  [t setString:self.string];
  [t
    enumerateTagsInRange:NSMakeRange(0, [[t string] length])
                  scheme:NSLinguisticTagSchemeTokenType
                 options:0
              usingBlock:
      ^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
      NSAttributedString *gs =
        [[NSAttributedString alloc]
            initWithString:@"["
                attributes:
            @{NSForegroundColorAttributeName:[AppColor tokenDelimiterColor]}];

      NSAttributedString *s =
        [[NSAttributedString alloc]
          initWithString:[[t string] substringWithRange:tokenRange]
              attributes:
            @{NSForegroundColorAttributeName:[AppColor tokenForegroundColor],
              NSBackgroundColorAttributeName:[AppColor tokenBackgroudColor]}];

      NSAttributedString *ge =
        [[NSAttributedString alloc]
         initWithString:@"]"
         attributes:
         @{NSForegroundColorAttributeName:[AppColor tokenDelimiterColor]}];

      [mas appendAttributedString:gs];
      [mas appendAttributedString:s];
      [mas appendAttributedString:ge];
    }];

  return mas;
}

- (NSAttributedString *)analyzeWithLemma
{
  if ([self.schemes indexOfObject:NSLinguisticTagSchemeLemma]
      == NSNotFound) {
    return [[NSAttributedString alloc] initWithString:self.string];
  }

  NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
  NSLinguisticTagger *t =
    [[NSLinguisticTagger alloc]
      initWithTagSchemes:@[NSLinguisticTagSchemeLemma]
                 options:0];
  [t setString:self.string];
  [t
    enumerateTagsInRange:NSMakeRange(0, [[t string] length])
                  scheme:NSLinguisticTagSchemeLemma
                 options:0
              usingBlock:
      ^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
      NSAttributedString *s;
      NSString *os = [[t string] substringWithRange:tokenRange];
      if (tag && ![tag isEqualToString:os]) {
        s = [[NSAttributedString alloc]
            initWithString:tag
                attributes:
            @{NSForegroundColorAttributeName:[AppColor lemmaChangedColor]}];
      } else {
        s = [[NSAttributedString alloc]
            initWithString:os
                attributes:
            @{NSForegroundColorAttributeName:[AppColor lemmaDefaultColor]}];
      }
      [mas appendAttributedString:s];
    }];

  return mas;
}

- (NSAttributedString *)analyzeWithLexicalClassWithHints:(NSArray *)hints
{
  if ([self.schemes indexOfObject:NSLinguisticTagSchemeLexicalClass]
      == NSNotFound) {
    return [[NSAttributedString alloc] initWithString:self.string];
  }

  NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
  NSLinguisticTagger *t =
    [[NSLinguisticTagger alloc]
      initWithTagSchemes:@[NSLinguisticTagSchemeLexicalClass]
                 options:0];
  [t setString:self.string];
  [t
    enumerateTagsInRange:NSMakeRange(0, [[t string] length])
                  scheme:NSLinguisticTagSchemeLexicalClass
                 options:0
              usingBlock:
      ^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
      UIColor *c = [AppColor lexicalDefaultColor];
      if (tag) {
        for (NSArray *a in hints) {
          if ([a[0] isEqual:tag]) {
            if ([a[1] boolValue]) {
              c = [Tagger colorForLexicalClass:tag];
            }
            break;
          }
        }
      }
      NSAttributedString *s =
        [[NSAttributedString alloc]
            initWithString:[[t string] substringWithRange:tokenRange]
                attributes:
            @{NSForegroundColorAttributeName:c}];
      [mas appendAttributedString:s];
    }];

  return mas;
}

- (NSAttributedString *)analyzeWithNameType
{
  if ([self.schemes indexOfObject:NSLinguisticTagSchemeNameType]
      == NSNotFound) {
    return [[NSAttributedString alloc] initWithString:self.string];
  }

  NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] init];
  NSLinguisticTagger *t =
    [[NSLinguisticTagger alloc]
      initWithTagSchemes:@[NSLinguisticTagSchemeNameType]
                 options:0];
  [t setString:self.string];
  [t
    enumerateTagsInRange:NSMakeRange(0, [[t string] length])
                  scheme:NSLinguisticTagSchemeNameType
                 options:0
              usingBlock:
      ^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
      NSString *s = [[t string] substringWithRange:tokenRange];
      UIColor *c = [AppColor nameDefaultColor];
      if ([tag isEqual:NSLinguisticTagPersonalName]) {
        c = [AppColor namePersonalColor];
      } else if ([tag isEqual:NSLinguisticTagPlaceName]) {
        c = [AppColor namePlaceColor];
      } else if ([tag isEqual:NSLinguisticTagOrganizationName]) {
        c = [AppColor nameOrganizationColor];
      }

      NSAttributedString *as =
        [[NSAttributedString alloc]
            initWithString:s
                attributes:
            @{NSForegroundColorAttributeName:c}];

      [mas appendAttributedString:as];
    }];

  return mas;
}

+ (UIColor *)colorForLexicalClass:(NSString *)lexicalClass
{
  UIColor *c = [AppColor lexicalDefaultColor];
  if ([lexicalClass isEqual:NSLinguisticTagNoun]) {
    c = [AppColor lexicalNounColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagVerb]) {
    c = [AppColor lexicalVerbColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagAdjective]) {
    c = [AppColor lexicalAdjectiveColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagAdverb]) {
    c = [AppColor lexicalAdverbColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagPronoun]) {
    c = [AppColor lexicalPronounColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagDeterminer]) {
    c = [AppColor lexicalDeterminerColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagParticle]) {
    c = [AppColor lexicalParticleColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagPreposition]) {
    c = [AppColor lexicalPrepositionColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagNumber]) {
    c = [AppColor lexicalNumberColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagConjunction]) {
    c = [AppColor lexicalConjunctionColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagInterjection]) {
    c = [AppColor lexicalInterjectionColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagClassifier]) {
    c = [AppColor lexicalClassifierColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagIdiom]) {
    c = [AppColor lexicalIdiomColor];
  } else if ([lexicalClass isEqual:NSLinguisticTagOtherWord]) {
    c = [AppColor lexicalOtherWordColor];
  }

/*
NSString *const NSLinguisticTagSentenceTerminator;
NSString *const NSLinguisticTagOpenQuote;
NSString *const NSLinguisticTagCloseQuote;
NSString *const NSLinguisticTagOpenParenthesis;
NSString *const NSLinguisticTagCloseParenthesis;
NSString *const NSLinguisticTagWordJoiner;
NSString *const NSLinguisticTagDash;
NSString *const NSLinguisticTagOtherPunctuation;
NSString *const NSLinguisticTagParagraphBreak;
NSString *const NSLinguisticTagOtherWhitespace;
*/
    return c;
}

@end

// EOF
