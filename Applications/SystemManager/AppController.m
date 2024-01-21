/* 
   Project: SystemManager

   Author: Ondrej Florian

   Created: 2024-01-19 23:40:24 +0100 by oflorian
   
   Application Controller
*/

#import "AppController.h"

@implementation AppController

+ (void) initialize {
  NSMutableDictionary *defaults = [NSMutableDictionary dictionary];

  [[NSUserDefaults standardUserDefaults] registerDefaults: defaults];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id) init {
  if ((self = [super init])) {
    systemWindow = [[SystemWindow alloc] init];
    consoleController = [[ConsoleController alloc] init];
  }
  return self;
}

- (void) dealloc {
  RELEASE(systemWindow);
  [super dealloc];
}

- (void) awakeFromNib {
}

- (void) applicationDidFinishLaunching:(NSNotification*)aNotif {
}

- (BOOL) applicationShouldTerminate:(id)sender {
  return YES;
}

- (void) applicationWillTerminate:(NSNotification*)aNotif {
}

- (BOOL) application:(NSApplication*)application
	    openFile:(NSString*)fileName {
  return NO;
}

- (void) control:(id)sender {
  NSWindow* panel = [consoleController  panel];
  NSString* exec = [[[[NSBundle mainBundle] resourcePath] 
    stringByAppendingPathComponent:@"commands"]
    stringByAppendingPathComponent:@"system_control"];

  NSString* type = nil;
  if ([sender tag] == 1) {
    type = @"shutdown";
  }
  if ([sender tag] == 2) {
    type = @"sleep";
  }
  if ([sender tag] == 3) {
    type = @"emergency";
  }
  if ([sender tag] == 4) {
    type = @"reboot";
  }

  if (type) {
    [self executeConsoleCommand:exec withArguments:[NSArray arrayWithObject:type]];
    [panel makeKeyAndOrderFront:self];
    [panel center];
  }
}

- (void) showSystemProcesses:(id)sender {
  [systemWindow showWindow];
  [systemWindow refresh:sender];
}

- (void) showSystemControl:(id)sender {
  [controlPanel center];
  [controlPanel makeKeyAndOrderFront:sender];
}

- (NSWindow*) executeConsoleCommand:(NSString*) exec withArguments:args{
  NSWindow* panel = [consoleController  panel];

  [consoleController execCommand:exec withArguments:args];
  [panel makeKeyAndOrderFront:self];
  [panel center];

  return panel;
}

- (void) showPrefPanel:(id)sender {
}

@end