/*
   Project: Librarian

   Copyright (C) 2022 Free Software Foundation

   Author: Ondrej Florian,,,

   Created: 2022-10-22 16:59:28 +0200 by oflorian

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "Inspector.h"
#import "Books.h"

@implementation Inspector

static Inspector* __sharedinstance;

- (id) init {
  self = [super init];
  [NSBundle loadNibNamed:@"Inspector" owner:self];
  [window setFrameAutosaveName:@"inspector_window"]; 

  [pathsTable setHeaderView:nil];

  return self;
}

+ (Inspector*) sharedInstance {
  if (!__sharedinstance) {
    __sharedinstance = [[Inspector alloc] init];
  }
  return __sharedinstance;
}

- (NSWindow*) window {
  return window;
}

- (void) inspectBooks:(Books*) books {
  ASSIGN(currentBooks, books);
  [pathsTable reloadData];
}

- (IBAction) rebuild:(id) sender {
  [currentBooks rebuild];
}

- (IBAction) addFolder:(id) sender {
  NSMutableArray* list = [NSMutableArray arrayWithArray:[currentBooks paths]];
  NSOpenPanel* panel = [NSOpenPanel openPanel];
  [panel setAllowsMultipleSelection: NO];
  [panel setCanChooseDirectories: YES];

  if ([panel runModalForTypes:nil] == NSOKButton) {
    [list addObjectsFromArray:[panel filenames]];
    [currentBooks setPaths:list];

    [pathsTable reloadData];
  }
}

- (IBAction) removeFolder:(id) sender {
}

- (NSInteger) numberOfRowsInTableView:(NSTableView*) table {
  return [[currentBooks paths] count];
}

- (id) tableView:(NSTableView*) table objectValueForTableColumn:(NSTableColumn*) col row:(NSInteger) row {
  return [[currentBooks paths] objectAtIndex:row];
}

@end