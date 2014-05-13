// -*- mode:objc -*-

@import Foundation;

@interface Tagger : NSObject

@property (nonatomic) NSString *string;
@property (nonatomic, readonly) NSArray *availableTagSchemes;

- (instancetype)initWithLanguage:(NSString *)language;
- (NSAttributedString *)analyzeWithTokenType;
- (NSAttributedString *)analyzeWithLemma;
- (NSAttributedString *)analyzeWithLexicalClassWithHints:(NSArray *)hints;
- (NSAttributedString *)analyzeWithNameType;

+ (UIColor *)colorForLexicalClass:(NSString *)lexicalClass;

@end

// EOF
