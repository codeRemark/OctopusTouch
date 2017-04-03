//
//  FTSystemSetting.m
//  QuickTouchClient
//
//  Created by TsuiYuenHong on 2016/11/11.
//  Copyright © 2016年 TsuiYuenHong. All rights reserved.
//

#import "QTSystemSetting.h"
OSStatus SendAppleEventToSystemProcess(AEEventID EventToSend)
{
    AEAddressDesc targetDesc;
    static const ProcessSerialNumber kPSNOfSystemProcess = { 0, kSystemProcess };
    AppleEvent eventReply = {typeNull, NULL};
    AppleEvent appleEventToSend = {typeNull, NULL};
    OSStatus error = noErr;
    error = AECreateDesc(typeProcessSerialNumber, &kPSNOfSystemProcess,
                         sizeof(kPSNOfSystemProcess), &targetDesc);
    if (error != noErr)
    {
        return(error);
    }
    error = AECreateAppleEvent(kCoreEventClass, EventToSend, &targetDesc,
                               kAutoGenerateReturnID, kAnyTransactionID, &appleEventToSend);
    AEDisposeDesc(&targetDesc);
    if (error != noErr)
    {
        return(error);
    }
    error = AESend(&appleEventToSend, &eventReply, kAENoReply,
                   kAENormalPriority, kAEDefaultTimeout, NULL, NULL);
    AEDisposeDesc(&appleEventToSend);
    if (error != noErr)
    {
        return(error);
    }
    AEDisposeDesc(&eventReply);
    return(error); 
}

@implementation QTSystemSetting

+ (void)setSystemBrightness:(float)level{
    io_iterator_t iterator;
    kern_return_t result = IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator);
    if (result == kIOReturnSuccess) {
        io_object_t service;
        while ((service = IOIteratorNext(iterator))) {
            IODisplaySetFloatParameter(service, kNilOptions, CFSTR(kIODisplayBrightnessKey), level);
            IOObjectRelease(service);
            return;
        }
    }
}

+ (void)setSystemVolume:(int)level{
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:[NSString stringWithFormat: @"set volume output volume %d",level]];
    [script executeAndReturnError:nil];
}

+ (SInt32)getSystemVolume{
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:@"output volume of (get volume settings)"];
    return [[script executeAndReturnError:nil] int32Value];
}

+ (void)sleepWithDelay:(int)delay{
    NSAppleScript *sleepScript = [[NSAppleScript alloc] initWithSource:[NSString stringWithFormat:@"delay %d \n tell application \"System Events\" \n\t sleep \n end tell",delay]];
    [sleepScript executeAndReturnError:nil];
}

+ (void)sleepNow{
    [QTSystemSetting sleepWithDelay:0];
}

+ (void)wakeup{
   
    
   // SendAppleEventToSystemProcess(kAEWakeUpEvent);
    
    CGEventSourceRef source = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    CGEventRef saveCommandDown = CGEventCreateKeyboardEvent(source, (CGKeyCode)1, YES);
    CGEventSetFlags(saveCommandDown, kCGEventFlagMaskCommand);
    CGEventRef saveCommandUp = CGEventCreateKeyboardEvent(source, (CGKeyCode)1, NO);
    
    CGEventPost(kCGAnnotatedSessionEventTap, saveCommandDown);
    CGEventPost(kCGAnnotatedSessionEventTap, saveCommandUp);
    
    CFRelease(saveCommandUp);
    CFRelease(saveCommandDown);
    CFRelease(source);
    return ;
     CGPostKeyboardEvent((CGCharCode)0, (CGKeyCode)3, false);
    CGPostKeyboardEvent((CGCharCode)0, (CGKeyCode)3, true);
    return ;
    NSAppleScript *sleepScript = [[NSAppleScript alloc] initWithSource:[NSString stringWithFormat:@"delay %d \n tell application \"System Events\" \n\t wake \n end tell",0]];
    [sleepScript executeAndReturnError:nil];
}

+ (void)shutdown{
    SendAppleEventToSystemProcess(kAEShutDown);
}


+ (void)fetchAllMenuItemNameOfApp:(NSString *)appName{
    NSString *scriptStr = [NSString stringWithFormat:@"tell application \"System Events\" to tell process \"%@\"\
                           \nname of every menu item of every menu of menu bar 1\
                           \nend tell",appName];
    NSAppleScript *clickMenuBarItemScript = [[NSAppleScript alloc] initWithSource:scriptStr];
    [clickMenuBarItemScript executeAndReturnError:nil];
}

+ (void)clickMenuItem:(NSString *)item ofMenu:(NSString *)menu ofMenuBar:(NSInteger)menuBar ofApplication:(NSString *)appName{
    NSString *scriptStr = [NSString stringWithFormat:@"tell application \"System Events\" to tell process \"%@\"\
                           \nset frontmost to true\
                           \nclick menu item \"%@\" of menu \"%@\" of menu bar %ld\
                           \nend tell",appName,item,menu,(long)menuBar];
    NSAppleScript *clickMenuBarItemScript = [[NSAppleScript alloc] initWithSource:scriptStr];
    [clickMenuBarItemScript executeAndReturnError:nil];
}

+ (void)clickSubMenuItem:(NSString *)subItem ofMenuItem:(NSString *)item ofMenu:(NSString *)menu ofMenuBar:(NSInteger)menuBar ofApplication:(NSString *)appName{
    NSString *scriptStr = [NSString stringWithFormat:@"tell application \"System Events\" to tell process \"%@\"\
                           \nset frontmost to true\
                           \nclick menu item \"%@\" of menu of menu item \"%@\" of menu \"%@\" of menu bar %ld\
                           \nend tell",appName,subItem,item,menu,(long)menuBar];
    NSAppleScript *clickMenuBarItemScript = [[NSAppleScript alloc] initWithSource:scriptStr];
    [clickMenuBarItemScript executeAndReturnError:nil];
}

+ (void)launchApp:(NSString *)name{
    [[NSWorkspace sharedWorkspace] launchApplication:name];
}

+ (void)playMusic{
    
    NSString* s = @"tell application \"iTunes\" \n play some track of playlist \"Library\"\n\t delay 0 \n stop \n end tell";
    NSLog(s);
    
    NSAppleScript * appScript = [[NSAppleScript alloc] initWithSource: s];
    
    [appScript executeAndReturnError:nil];
    
}

+ (NSString *)getLocalIPAddress{
    NSString *stringAddress;
    NSArray *addresses = [[NSHost currentHost] addresses];
    for (NSString *anAddress in addresses) {
        if (![anAddress hasPrefix:@"127"] && [[anAddress componentsSeparatedByString:@"."] count] == 4) {
            stringAddress = anAddress;
            break;
        } else {
            stringAddress = @"IPv4 address not available" ;
        }
    }
    return stringAddress;
}

@end
