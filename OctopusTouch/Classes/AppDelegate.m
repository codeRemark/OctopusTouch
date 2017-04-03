//
//  AppDelegate.m
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "AppDelegate.h"
#import "WebServer.h"
#import "PreferenceController.h"
#import "ResourceHelper.h"
#import "FileHelper.h"
#import <ApplicationServices/ApplicationServices.h>

@interface AppDelegate() <NSMenuDelegate>{
    
    NSWindowController * _about;
    PreferenceController* _preferences;
    IBOutlet NSMenuItem* _switchMenu;
}

@end

@implementation AppDelegate


- (void)awakeFromNib {
    if (AXIsProcessTrustedWithOptions != NULL) {
        // 10.9 and later
        const void* keys[] = {kAXTrustedCheckOptionPrompt};
        const void* values[] = {kCFBooleanTrue};
        
        CFDictionaryRef options = CFDictionaryCreate(
                                                     kCFAllocatorDefault,
                                                     keys,
                                                     values,
                                                     sizeof(keys) / sizeof(*keys),
                                                     &kCFCopyStringDictionaryKeyCallBacks,
                                                     &kCFTypeDictionaryValueCallBacks);
        
        AXIsProcessTrustedWithOptions(options);
    }
    
    NSImage* menuIcon = [NSImage imageNamed:@"StatusIcon"];
    
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [_statusItem setMenu:_menu];
    [_statusItem setImage:menuIcon];
    [_statusItem setHighlightMode:YES];
    
#ifdef DEBUG
    [self initKeyHandler];
#endif
    
    [[AppManager sharedInstance] setupSpace];
    
    [self registerListener];
    
}


- (void)initKeyHandler {
    _keyHandler = [[KeyHandler alloc] init];

    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:_keyHandler
                                                           selector:@selector(appDidActivate:)
                                                               name:NSWorkspaceDidActivateApplicationNotification
                                                             object:nil];

    [NSEvent addGlobalMonitorForEventsMatchingMask:NSKeyDownMask
                                           handler:^(NSEvent* event) {
                                               [_keyHandler handleKeyPress:event];
                                           }];
}

- (void)dealloc {
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:_keyHandler];
}

- (IBAction)onTapSwitchButton:(id)sender{
    
    BOOL running = [[WebServer sharedInstance] isRunning];
    [[AppManager sharedInstance]controlWebServer:!running];
    
}

- (void)exitAction:(id)senderId {
    exit(0);
}


- (IBAction)showAbout:(id)sender;
{
    if(!_about)
    {
        _about = [[NSWindowController alloc] initWithWindowNibName: @"About"];
    }
    
    [_about showWindow: self];
    [NSApp activateIgnoringOtherApps: YES];
}

- (PreferenceController *) preferences
{
    if(!_preferences)
    {
        _preferences = [[PreferenceController alloc] initWithWindowNibName: @"PreferenceController"];
    }
    
    return _preferences;
}

- (IBAction) showPreferences: (id) sender
{
    [[self preferences] showWindow: self];
    [NSApp activateIgnoringOtherApps: YES];
}

- (void)renderMenu{
    BOOL running = [[WebServer sharedInstance]isRunning];
    
    //@step
    NSString* title =  running ? AppLocalizedString(@"Stop"):AppLocalizedString(@"Start");
    [_switchMenu setTitle:title];
}
#pragma -mark
#pragma Server Event
- (void)onServerStateChanged:(NSNotification*)notification{
    NSLog(@"%@", notification);
    [self renderMenu];
}

- (void)registerListener{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onServerStateChanged:) name:kServerEvent object:nil];
}



@end
