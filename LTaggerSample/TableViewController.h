// -*- mode:objc -*-

@import UIKit;

@class ViewController;
@interface TableViewController : UITableViewController

@property (weak, nonatomic) ViewController *mainViewController;
@property (nonatomic) NSMutableArray *lexicalClassHints;

@end

// EOF
