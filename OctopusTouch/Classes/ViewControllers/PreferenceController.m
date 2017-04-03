//
//  PreferenceController.m
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "PreferenceController.h"
#import "QRCodeHelper.h"
#import "WebServer.h"

#define PREFERENCES_FILE \
[@"~/Library/Preferences/com.ixkit.octopustouch.plist" stringByExpandingTildeInPath]



@interface PreferenceController ()<NSTextFieldDelegate>{
   
    BOOL firstRun;
    NSInteger openOnLoginState;
    
    IBOutlet NSTextField* _hostField;
    IBOutlet NSTextField* _portField;
    IBOutlet NSTextField* _tokenField;
    
    IBOutlet NSTextField* _userField;
    
    IBOutlet NSTextField* _linkLabel;
    
    IBOutlet NSImageView* _linkImageView;
    
    BOOL _runtimeConfigChanged;
    
    IBOutlet NSButton* _ctrlButton;
}

@end

@implementation PreferenceController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
   
    [self registerListener];
}

- (void)windowDidChangeOcclusionState:(NSNotification *)notification
{
    // notification.object is the window that changed its state.
    // It's safe to use self.window instead if you don't assign one delegate to many windows
    NSWindow *window = notification.object;
    
    // check occlusion binary flag
    if (window.occlusionState & NSWindowOcclusionStateVisible)
    {
        // your code here
        [self updateView];
    }
    
    [_linkImageView becomeFirstResponder];
}

- (void)updateView{
    NSLog(@"%@->updateView",self);
    
    [self renderView];
    
    [self renderRunningServer];
}
 
- (void)renderView{
    NSString* port = [Resources getServerPort];
    NSString* token = [Resources getAccessToken];
    [_portField setStringValue:port];
    [_tokenField setStringValue:token];
    
    [_userField setStringValue:[Resources getMasterName]];
    
   
}

- (void)renderRunningServer{
    BOOL running = [[WebServer sharedInstance]isRunning];
    
    NSImage* image = [Resources getServerURLAsQRImage];
    if (!running || nil == image){
        image = [NSImage imageNamed:@"octopus.png"];
    }
    _linkImageView.image = image;
    
    //@step
    NSString* link = @"";
    [_linkLabel setStringValue:link];
    if (running){
        link = [Resources getServerURLString];
        [_linkLabel setStringValue:link];
        NSURL* url = [NSURL URLWithString:link];
        link = [NSString stringWithFormat:@"%@://%@",[url scheme],  [url host] ];
    }
    
    [_hostField setStringValue:link];
    
    //@step
    NSString* title =  running ? AppLocalizedString(@"Stop"):AppLocalizedString(@"Start");
    [_ctrlButton setTitle:title];
}

- (BOOL)save{
    NSString* port = [_portField stringValue];
    NSString* token = [_tokenField stringValue];
    [Resources setServerPort:port];
    [Resources setAccessToken:token];
    
    return true;
}

- (IBAction)onTapSwitchButton:(id)sender{
    BOOL running = [[WebServer sharedInstance] isRunning];
    [[AppManager sharedInstance]controlWebServer:!running];
   
}

- (IBAction)done:(id)sender{
    if (_runtimeConfigChanged){
        [self save];
        _runtimeConfigChanged = false;
    }
    
    [self close];
}



- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];
    NSLog(@"[%@ %@] stringValue == %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [textField stringValue]);
    _runtimeConfigChanged =true ;
}

- (void)onServerStateChanged:(NSNotification*)notification{
    NSLog(@"%@", notification);
    
    [self performSelector:@selector(updateView) withObject:nil afterDelay:0.01];
}

- (void)registerListener{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onServerStateChanged:) name:kServerEvent object:nil];
}



- (void) load_disc
{
    NSDictionary *preferences = [NSDictionary dictionaryWithContentsOfFile: PREFERENCES_FILE];
    
    // Read the HostsList
    
    NSArray *values = [preferences objectForKey: @"Hosts"];
    NSMutableDictionary *hostsDict = [[NSMutableDictionary alloc] init];
    
    
    // Read the OpenOnLogin preference
    
    firstRun = ![[preferences allKeys] containsObject: @"OpenOnLogin"];
    
    if(firstRun)
    {
        openOnLoginState = NSOnState;
        [self setOpenOnLogin: YES];
        [self save];
    }
    else
    {
        NSString *value = [preferences valueForKey: @"OpenOnLogin"];
        openOnLoginState = [value compare: @"1"] == NSOrderedSame ? NSOnState : NSOffState;
    }
}



- (void) setOpenOnLogin: (BOOL) open
{
    CFURLRef url = (CFURLRef) CFBridgingRetain([NSURL fileURLWithPath: [[NSBundle mainBundle] bundlePath]]);
    
    LSSharedFileListRef items =
    LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    
    if(open)
    {
        LSSharedFileListItemRef item =
        LSSharedFileListInsertItemURL(items, kLSSharedFileListItemLast, NULL, NULL,
                                      url, NULL, NULL);
        CFRelease(item);
    }
    else
    {
        UInt32 seedValue;
        NSArray *values = (NSArray *) CFBridgingRelease(LSSharedFileListCopySnapshot(items, &seedValue));
        
        for(NSUInteger i = 0; i < [values count]; i++)
        {
            LSSharedFileListItemRef itemRef =
            (LSSharedFileListItemRef)CFBridgingRetain([values objectAtIndex: i]);
            
            if(LSSharedFileListItemResolve(itemRef, 0, (CFURLRef *) &url, NULL) == noErr)
            {
                NSString *urlPath = [(NSURL *) CFBridgingRelease(url) path];
                
                if([urlPath compare: [[NSBundle mainBundle] bundlePath]] == NSOrderedSame)
                {
                    LSSharedFileListItemRemove(items, itemRef);
                }
            }
        }
        
        
    }
    
    CFRelease(items);
}



@end
