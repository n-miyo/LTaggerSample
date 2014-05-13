// -*- mode:objc -*-

#import "ViewController.h"

#import "Tagger.h"
#import "TableViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *languageButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UIBarButtonItem *lexicalClassButton;
@property (nonatomic) NSArray *linguisticSchemeTable;
@property (nonatomic) NSArray *languageTable;
@property (nonatomic) UIFont *defaultFont;
@property (nonatomic) Tagger *tagger;
@property (nonatomic) NSInteger currentLanguage;
@property (nonatomic) NSString *baseText;
@property (nonatomic) NSMutableArray *lexicalClassHints;

@end

@implementation ViewController

static NSString *kEnglishBaseText =
  @"Apple Updates MacBook Air\n"
  @"April 29, 2014\n"
  @"Apple today updated the MacBook Air lineup with faster processors and lower prices. Now starting at $899, the ultra-thin notebooks feature powerful Intel Core i5 or Core i7 processors, fast flash storage, 802.11ac Wi-Fi, up to 12 hours of battery life, and Apple’s iLife and iWork apps. “With MacBook Air starting at $899, there’s no reason to settle for anything less than a Mac,” said Philip Schiller, Apple’s senior vice president of Worldwide Marketing. “Macs have never been more popular, and today we’ve boosted the performance and lowered the price of MacBook Air so even more people can experience the perfect everyday notebook.";

static NSString *kGermanBaseText =
  @"Apple aktualisiert MacBook Air\n"
  @"Mi, 30. April 2014\n"
  @"Apple hat heute die MacBook Air-Familie mit schnelleren Prozessoren und günstigeren Preisen aktualisiert. Ab sofort beginnend zu einem Preis ab 899 Euro verfügt das ultradünne Notebook über leistungsfähige Intel Core i5- oder Core i7-Prozessoren, schnellen Flash-Speicher, 802.11ac Wi-Fi, bis zu 12 Stunden Batterielaufzeit und Apples iLife und iWork Apps. “Mit dem MacBook Air verfügbar ab 899 Euro gibt es keinen Grund, sich mit weniger als einem Mac zufrieden zu geben,” sagt Philip Schiller, Senior Vice President Worldwide Marketing von Apple. “Macs sind so beliebt wie niemals zuvor und heute haben wir die Leistung des MacBook Air gesteigert und den Preis gesenkt, damit noch mehr Nutzer das ultimative Alltags-Notebook erleben können.” ";

static NSString *kFrenchBaseText =
  @"Apple met à jour le MacBook Air\n"
  @"Mercredi 30 avril 2014\n"
  @"Apple a mis à jour aujourd’hui la gamme MacBook Air avec des processeurs plus rapides et des tarifs revus à la baisse. Proposés à partir de 899 €, les portables ultra fins intègrent de puissants processeurs Intel Core i5 ou Core i7, un stockage flash rapide, une connectivité Wi-Fi 802.11ac, jusqu’à 12 heures d’autonomie, ainsi que les apps iLife et iWork d’Apple. « Avec un MacBook Air proposé à partir de 899 €, il n’y a plus aucune raison de ne pas choisir un Mac », a déclaré Philip Schiller, senior vice president of Worldwide Marketing d’Apple. « Les Mac n’ont jamais été aussi populaires, et aujourd’hui, nous avons augmenté les performances et baissé le prix du MacBook Air pour permettre à encore plus de personnes de découvrir l’ordinateur portable idéal au quotidien. ";

static NSString *kJapaneseBaseText =
  @"Apple、MacBook Airをアップデート\n"
  @"2014年4月29日\n"
  @"2014年4月29日、Appleは本日、MacBook Airにより高速なプロセッサを搭載し、価格を引き下げるという、毎日のためのパーフェクトなノートブックの価値をさらに高めるアップデートを行ないました。新価格が88,800円（税別）からとなったMacBook Airは、パワフルなプロセッサ、高速なフラッシュストレージ、802.11ac Wi-Fi、最長12時間のバッテリー駆動時間、AppleのiLifeおよびiWorkアプリケーションを標準装備して、一日中作業をするのに必要なすべてを提供します。";

static NSString *kChineseBaseText =
  @"Apple 更新 MacBook Air\n"
  @"2014 年 4 月 29 日\n"
  @"Apple 今日更新了 MacBook Air 系列产品，配备了更快的处理器并调低了售价。这款超薄笔记本电脑现以 RMB 6,288 起售，配备强劲的 Intel Core i5 或 Core i7 处理器、高速闪存、802.11ac Wi-Fi、长达 12 小时的电池使用时间，以及 Apple 的 iLife 和iWork app 套件。\"有了起售价为 RMB 6,288 的 MacBook Air，用户再也不必舍 Mac 而求其次了。\" Apple 全球市场营销高级副总裁 Philip Schiller 表示。\"Mac 从未如此广受欢迎，而今我们又提升了 MacBook Air 的性能并调低了售价，因此将有更多人能体验到这款理想的日常用笔记本电脑。\"";

static NSString *kSegue = @"lexicalClassSegue";

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.doneButton =
    [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                           target:self
                           action:@selector(pressedDoneButton:)];
  self.doneButton.enabled = NO;

  self.lexicalClassButton =
    [[UIBarButtonItem alloc]
      initWithTitle:@"Class"
              style:UIBarButtonItemStylePlain
             target:self
             action:@selector(pressedLexicalClassButton:)];
  self.doneButton.enabled = NO;
  self.navigationItem.rightBarButtonItem = self.doneButton;

  self.textView.delegate = self;
  self.linguisticSchemeTable = @[
    @[@"__ORIGINAL__", @"Original"],
      @[NSLinguisticTagSchemeTokenType, @"Token"],
      @[NSLinguisticTagSchemeLemma, @"Lemma"],
      @[NSLinguisticTagSchemeLexicalClass, @"Lex"],
      @[NSLinguisticTagSchemeNameType, @"Name"]];
  self.languageTable = @[
    @[@"en", kEnglishBaseText,  @"English"],
    @[@"de", kGermanBaseText,  @"German"],
    @[@"fr", kFrenchBaseText,  @"French"],
    @[@"ja", kJapaneseBaseText, @"Japanese"],
    @[@"cn", kChineseBaseText, @"Chinese"],
  ];
  self.defaultFont = [UIFont systemFontOfSize:14.0f];

  self.lexicalClassHints = [@[
    @[NSLinguisticTagNoun, @(YES)],
    @[NSLinguisticTagVerb, @(YES)],
    @[NSLinguisticTagAdjective, @(YES)],
    @[NSLinguisticTagAdverb, @(YES)],
    @[NSLinguisticTagPronoun, @(YES)],
    @[NSLinguisticTagDeterminer, @(YES)],
    @[NSLinguisticTagParticle, @(YES)],
    @[NSLinguisticTagPreposition, @(YES)],
    @[NSLinguisticTagNumber, @(YES)],
    @[NSLinguisticTagConjunction, @(YES)],
    @[NSLinguisticTagInterjection, @(YES)],
    @[NSLinguisticTagClassifier, @(YES)],
    @[NSLinguisticTagIdiom, @(YES)],
    @[NSLinguisticTagOtherWord, @(YES)],
  ] mutableCopy];
  self.currentLanguage = -1;    // XXX
  [self pressedLanguageChangeButton:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  [[NSNotificationCenter defaultCenter]
    addObserver:self
       selector:@selector(keyboardWasShown:)
           name:UIKeyboardDidShowNotification
         object:nil];

  [[NSNotificationCenter defaultCenter]
    addObserver:self
       selector:@selector(keyboardWillBeHidden:)
           name:UIKeyboardWillHideNotification
         object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];

  [[NSNotificationCenter defaultCenter]
    removeObserver:self
              name:UIKeyboardDidShowNotification
            object:nil];

  [[NSNotificationCenter defaultCenter]
    removeObserver:self
              name:UIKeyboardWillHideNotification
            object:nil];
}

- (BOOL)shouldAutorotate
{
  return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskAll;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:kSegue]) {
    TableViewController *v =
      (TableViewController *)
      ((UINavigationController *)segue.destinationViewController).
      topViewController;
    v.mainViewController = self;
    v.lexicalClassHints = self.lexicalClassHints;
  }
}

#pragma mark - IBActions

- (IBAction)pressedLanguageChangeButton:(UIBarButtonItem *)sender
{
  self.currentLanguage = (self.currentLanguage+1) % [self.languageTable count];
  NSArray *a = self.languageTable[self.currentLanguage];
  self.baseText = a[1];
  self.navigationItem.title = a[2];

  self.tagger = [[Tagger alloc] initWithLanguage:a[0]];
  [self setupCategorySegments];

  self.textView.attributedText =
    [[NSAttributedString alloc]
      initWithString:self.baseText
          attributes:@{NSFontAttributeName:self.defaultFont}];
  [self.textView resignFirstResponder];
}

- (IBAction)pressedCategoryChangeSegment:(UISegmentedControl *)sender
{
  NSAttributedString *as;
  self.tagger.string = self.baseText;
  self.textView.editable = NO;
  self.navigationItem.rightBarButtonItem = nil;

  switch (sender.selectedSegmentIndex) {
  case 0:
    as = [[NSAttributedString alloc] initWithString:self.baseText];
    self.textView.editable = YES;
    self.navigationItem.rightBarButtonItem = self.doneButton;
    break;
  case 1:
    as = [self.tagger analyzeWithTokenType];
    break;
  case 2:
    as = [self.tagger analyzeWithLemma];
    break;
  case 3:
    as = [self.tagger analyzeWithLexicalClassWithHints:self.lexicalClassHints];
    self.navigationItem.rightBarButtonItem = self.lexicalClassButton;
    break;
  case 4:
    as = [self.tagger analyzeWithNameType];
    break;
  }

  NSMutableAttributedString *mas = [as mutableCopy];
  [mas
    addAttributes:@{NSFontAttributeName:self.defaultFont}
    range:NSMakeRange(0, [[as string] length])];
  self.textView.attributedText = mas;
  [self.textView resignFirstResponder];
}

#pragma mark - Public

- (void)refreshTextView
{
  [self pressedCategoryChangeSegment:self.segmentedControl]; // XXX
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
  self.doneButton.enabled = YES;
  return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
  self.doneButton.enabled = NO;
}

#pragma mark - Private

- (void)pressedDoneButton:(UIBarButtonItem *)sender
{
  self.baseText = [self.textView.attributedText string];
  [self.textView resignFirstResponder];
}

- (void)pressedLexicalClassButton:(UIBarButtonItem *)sender
{
  [self performSegueWithIdentifier:kSegue sender:self];
}

- (void)setupCategorySegments
{
  NSAssert(self.tagger, @"tagger should not be nil.");
  [self.segmentedControl removeAllSegments];

  NSUInteger c = [self.linguisticSchemeTable count];
  for (NSUInteger i = 0; i < c; i++) {
    NSArray *a = self.linguisticSchemeTable[i];
    [self.segmentedControl insertSegmentWithTitle:a[1] atIndex:i animated:NO];
    [self.segmentedControl setEnabled:NO forSegmentAtIndex:i];
    NSUInteger j = [self.tagger.availableTagSchemes indexOfObject:a[0]];
    if (i == 0 || j != NSNotFound) {
      [self.segmentedControl setEnabled:YES forSegmentAtIndex:i];
    }
  }

  self.segmentedControl.selectedSegmentIndex = 0;
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
  NSDictionary* info = [aNotification userInfo];
  CGSize kbSize =
    [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
  NSTimeInterval duration =
    [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationOptions curve =
    [info[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];

  UIEdgeInsets contentInset = self.textView.contentInset;
  UIEdgeInsets scrollInset = self.textView.scrollIndicatorInsets;
  contentInset.bottom = kbSize.height;
  scrollInset.bottom = kbSize.height;

  [UIView animateWithDuration:duration
                        delay:0.0
                      options:curve
                   animations:^{
      self.textView.contentInset = contentInset;
      self.textView.scrollIndicatorInsets = scrollInset;
    }
  completion:nil];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
  NSDictionary *info = [aNotification userInfo];
  NSTimeInterval duration =
    [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationOptions curve =
    [info[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];

  UIEdgeInsets contentInset = self.textView.contentInset;
  UIEdgeInsets scrollInset = self.textView.scrollIndicatorInsets;
  contentInset.bottom = 0;
  scrollInset.bottom = 0;

  [UIView animateWithDuration:duration
                        delay:0.0
                      options:curve
                   animations:^{
      self.textView.contentInset = contentInset;
      self.textView.scrollIndicatorInsets = scrollInset;
    }
  completion:nil];
}

@end

// EOF
