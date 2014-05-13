// -*- mode:objc -*-

#import "CNavigationController.h"

#import "Tagger.h"

@interface CNavigationController ()
@end

@implementation CNavigationController

- (BOOL)shouldAutorotate
{
  return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
  return [self.topViewController supportedInterfaceOrientations];
}

@end

// EOF
