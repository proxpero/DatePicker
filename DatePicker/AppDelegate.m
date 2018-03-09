#import "AppDelegate.h"
#import "DatePicker-Swift.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIWindow *w = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    RootViewController *vc = [RootViewController new];
    [w setRootViewController:vc];
    [w makeKeyAndVisible];

    self.window = w;

    return YES;
}

@end

