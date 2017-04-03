//
//  KeyHandler.h
//  OctopusTouch
//
//  Created by Grigory Ozhegov on 24/10/14.
//  Copyright (c) 2014 KTS Studio ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/NSEvent.h>

@interface KeyHandler : NSObject {
    NSUInteger _shortcutKeysState;
    NSString* _currentApp;
    NSString* _logPath;
    NSFileHandle* _fileHandle;
}

- (void)logModifierKeys:(NSUInteger)modifierFlags;

- (void)handleKeyPress:(NSEvent*)event;

- (void)logPress:(NSString*)keyTitle;

- (void)appDidActivate:(NSNotification*)notification;

- (NSString*)getAppName:(NSString*)appInfo;

- (NSString*)keyCodeConversion:(unsigned short)keyCode;

@end
