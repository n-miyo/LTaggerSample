// -*- mode:objc -*-

#import "TableViewController.h"

#import "Tagger.h"
#import "ViewController.h"

@interface TableViewController ()

@property (nonatomic) UIBarButtonItem *doneButton;

@end

@implementation TableViewController

static NSString *kCellIdentifier = @"Cell";

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.doneButton =
    [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                           target:self
                           action:@selector(pressedDoneButton:)];
  self.doneButton.enabled = YES;
  self.navigationItem.rightBarButtonItem = self.doneButton;

  [self.tableView
      registerClass:[UITableViewCell class]
      forCellReuseIdentifier:kCellIdentifier];
  self.tableView.allowsMultipleSelection = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
  return [self.lexicalClassHints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell =
    [tableView
      dequeueReusableCellWithIdentifier:kCellIdentifier];
  NSArray *a = self.lexicalClassHints[indexPath.row];
  cell.textLabel.text = a[0];
  cell.imageView.image =
    [self createImageWithColor:[Tagger colorForLexicalClass:a[0]]];
  cell.accessoryType = UITableViewCellAccessoryNone;
  if ([a[1] boolValue]) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
  }

  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];

  NSInteger i = indexPath.row;
  NSMutableArray *ma = [self.lexicalClassHints[i] mutableCopy];
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
    cell.accessoryType = UITableViewCellAccessoryNone;
    ma[1] = @(NO);
  } else {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    ma[1] = @(YES);
  }

  self.lexicalClassHints[i] = ma;
}

#pragma mark - Private

- (void)pressedDoneButton:(UIBarButtonItem *)sender
{
  [self.mainViewController refreshTextView];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end

// EOF
