//
//  AppDelegate.h
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KeyHandler.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu* _menu;
    NSStatusItem* _statusItem;
    KeyHandler* _keyHandler;
}

 

- (IBAction)exitAction:(id)sender;



@end

