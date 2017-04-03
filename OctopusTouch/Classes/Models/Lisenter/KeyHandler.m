//
//  KeyHandler.m
//  OctopusTouch
//
//  Created by Grigory Ozhegov on 24/10/14.
//  Copyright (c) 2014 KTS Studio ltd. All rights reserved.
//  Thanks https://github.com/mosca1337/OSX-Keylogger

#import "KeyHandler.h"
#import <Carbon/Carbon.h>

@implementation KeyHandler
- (id)init {
    _currentApp = [[NSString alloc] init];
    _logPath = [NSString stringWithFormat:@"%@%@", NSHomeDirectory(), @"/keys.log"];

    NSFileManager* fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:_logPath]) {
        if (![fileManager createFileAtPath:_logPath contents:nil attributes:nil]) {
            exit(1);
        }
    }

    _fileHandle = [NSFileHandle fileHandleForWritingAtPath:_logPath];
    [_fileHandle seekToEndOfFile];
    return self;
}

- (void)appDidActivate:(NSNotification*)notification {
    NSDictionary* userInfo = [notification userInfo];
    NSString* applicationInfo = userInfo[@"NSWorkspaceApplicationKey"];
    if (applicationInfo) {
        applicationInfo = [applicationInfo description];
    }

    NSString* appName = [self getAppName:applicationInfo];

    if (![appName isEqualToString:_currentApp]) {
        _currentApp = appName;
    }
}

- (void)handleKeyPress:(NSEvent*)event {
    unsigned short keyCode = [event keyCode];
    NSUInteger modifierFlags = [event modifierFlags];

    
    [self logModifierKeys:modifierFlags];
    [self logPress:[self keyCodeConversion:keyCode]];
}

- (void)logModifierKeys:(NSUInteger)modifierFlags {
    bool isCapsLock = (bool) (modifierFlags & NSAlphaShiftKeyMask);
    bool isShift = (bool) (modifierFlags & NSShiftKeyMask);
    bool isControl = (bool) (modifierFlags & NSControlKeyMask);
    bool isOption = (bool) (modifierFlags & NSAlternateKeyMask);
    bool isCommand = (bool) (modifierFlags & NSCommandKeyMask);

    bool wasCapsLock = (bool) (_shortcutKeysState & NSAlphaShiftKeyMask);
    bool wasShift = (bool) (_shortcutKeysState & NSShiftKeyMask);
    bool wasControl = (bool) (_shortcutKeysState & NSControlKeyMask);
    bool wasOption = (bool) (_shortcutKeysState & NSAlternateKeyMask);
    bool wasCommand = (bool) (_shortcutKeysState & NSCommandKeyMask);

    if (!isShift && wasShift) {
        [self logPress:@"Shift"];
    } else if (!isCapsLock && wasCapsLock) {
        [self logPress:@"CapsLock"];
    } else if (!isControl && wasControl) {
        [self logPress:@"Control"];
    } else if (!isOption && wasOption) {
        [self logPress:@"Option"];
    } else if (!isCommand && wasCommand) {
        [self logPress:@"Command"];
    }

    //todo implement log key combination. Sample of code below
    /*if (isShift && !wasShift) {
        [logLine appendString:@"<Shift>"];
    }

    if (isCapsLock && !wasCapsLock) {
        [logLine appendString:@"<Caps Lock>"];
    }

    if (isControl && !wasControl) {
        [logLine appendString:@"<Control>"];
    }

    if (isOption && !wasOption) {
        [logLine appendString:@"<Option>"];
    }

    if (isCommand && !wasCommand) {
        [logLine appendString:@"<Command>"];
    }*/
    _shortcutKeysState = modifierFlags;
}

- (void)logPress:(NSString*)key {
    NSString* logLine = [NSString stringWithFormat:@"%li %@ %@\n", (long) ([[NSDate date] timeIntervalSince1970] * 1000), _currentApp, key];
    NSLog(@"%@", logLine);
   // [_fileHandle writeData:[logLine dataUsingEncoding:NSUTF8StringEncoding]];
}


- (NSString*)getAppName:(NSString*)appInfo {
    NSString* appName = NULL;
    @try {
        NSRange startRange = [appInfo rangeOfString:@"("];
        NSRange endRange = [appInfo rangeOfString:@" - "];
        NSRange searchRange = NSMakeRange(startRange.location + startRange.length,
                (endRange.location - startRange.location) - 1);
        appName = [appInfo substringWithRange:searchRange];

        NSArray* names = [appName componentsSeparatedByString:@"."];
        if (names) {
            appName = [names objectAtIndex:[names count] - 1];
        }
    }
    @catch (NSException* e) {
        NSLog(@"Exception: %@", e);
    }
    return appName;
}

- (NSString*)keyCodeConversion:(unsigned short)keyCode {
    switch (keyCode) {
        case kVK_ANSI_A:
            return @"a";
        case kVK_ANSI_S:
            return @"s";
        case kVK_ANSI_D:
            return @"d";
        case kVK_ANSI_F:
            return @"f";
        case kVK_ANSI_H:
            return @"h";
        case kVK_ANSI_G:
            return @"g";
        case kVK_ANSI_Z:
            return @"z";
        case kVK_ANSI_X:
            return @"x";
        case kVK_ANSI_C:
            return @"c";
        case kVK_ANSI_V:
            return @"v";
        case kVK_ANSI_B:
            return @"b";
        case kVK_ANSI_Q:
            return @"q";
        case kVK_ANSI_W:
            return @"w";
        case kVK_ANSI_E:
            return @"e";
        case kVK_ANSI_R:
            return @"r";
        case kVK_ANSI_T:
            return @"t";
        case kVK_ANSI_Y:
            return @"y";
        case kVK_ANSI_1:
            return @"1";
        case kVK_ANSI_2:
            return @"2";
        case kVK_ANSI_3:
            return @"3";
        case kVK_ANSI_4:
            return @"4";
        case kVK_ANSI_6:
            return @"6";
        case kVK_ANSI_5:
            return @"5";
        case kVK_ANSI_Equal:
            return @"=";
        case kVK_ANSI_9:
            return @"9";
        case kVK_ANSI_7:
            return @"7";
        case kVK_ANSI_Minus:
            return @"-";
        case kVK_ANSI_8:
            return @"8";
        case kVK_ANSI_0:
            return @"0";
        case kVK_ANSI_RightBracket:
            return @"]";
        case kVK_ANSI_O:
            return @"o";
        case kVK_ANSI_U:
            return @"u";
        case kVK_ANSI_LeftBracket:
            return @"[";
        case kVK_ANSI_I:
            return @"i";
        case kVK_ANSI_P:
            return @"p";
        case kVK_ANSI_L:
            return @"l";
        case kVK_ANSI_J:
            return @"j";
        case kVK_ANSI_Quote:
            return @"'";
        case kVK_ANSI_K:
            return @"k";
        case kVK_ANSI_Semicolon:
            return @"a";
        case kVK_ANSI_Backslash:
            return @"\\";
        case kVK_ANSI_Comma:
            return @",";
        case kVK_ANSI_Slash:
            return @"/";
        case kVK_ANSI_N:
            return @"n";
        case kVK_ANSI_M:
            return @"m";
        case kVK_ANSI_Period:
            return @".";
        case kVK_ANSI_Grave:
            return @"`";
        case kVK_ANSI_KeypadDecimal:
            return @".";
        case kVK_ANSI_KeypadMultiply:
            return @"*";
        case kVK_ANSI_KeypadPlus:
            return @"+";
        case kVK_ANSI_KeypadClear:
            return @"Clear";
        case kVK_ANSI_KeypadDivide:
            return @"/";
        case kVK_ANSI_KeypadEnter:
            return @"Enter";
        case kVK_ANSI_KeypadMinus:
            return @"-";
        case kVK_ANSI_KeypadEquals:
            return @"=";
        case kVK_ANSI_Keypad0:
            return @"0";
        case kVK_ANSI_Keypad1:
            return @"1";
        case kVK_ANSI_Keypad2:
            return @"2";
        case kVK_ANSI_Keypad3:
            return @"3";
        case kVK_ANSI_Keypad4:
            return @"4";
        case kVK_ANSI_Keypad5:
            return @"5";
        case kVK_ANSI_Keypad6:
            return @"6";
        case kVK_ANSI_Keypad7:
            return @"7";
        case kVK_ANSI_Keypad8:
            return @"8";
        case kVK_ANSI_Keypad9:
            return @"9";
        case kVK_Return:
            return @"Return";
        case kVK_Tab:
            return @"Tab";
        case kVK_Space:
            return @"Space";
        case kVK_Delete:
            return @"Delete";
        case kVK_Escape:
            return @"Escape";
        case kVK_F1:
            return @"F1";
        case kVK_F2:
            return @"F2";
        case kVK_F3:
            return @"F3";
        case kVK_F4:
            return @"F4";
        case kVK_F5:
            return @"F5";
        case kVK_F6:
            return @"F6";
        case kVK_F7:
            return @"F7";
        case kVK_F8:
            return @"F8";
        case kVK_F9:
            return @"F9";
        case kVK_F10:
            return @"F10";
        case kVK_F11:
            return @"F11";
        case kVK_F12:
            return @"F12";
        case kVK_F13:
            return @"F13";
        case kVK_F14:
            return @"F14";
        case kVK_F15:
            return @"F15";
        case kVK_F16:
            return @"F16";
        case kVK_F17:
            return @"F17";
        case kVK_F18:
            return @"F18";
        case kVK_F19:
            return @"F19";
        case kVK_F20:
            return @"F20";
        case kVK_ForwardDelete:
            return @"Del";
        case kVK_LeftArrow:
            return @"LeftArrow";
        case kVK_RightArrow:
            return @"RightArrow";
        case kVK_DownArrow:
            return @"DownArrow";
        case kVK_UpArrow:
            return @"UpArrow";
        default:
            return @"Unknown";
    }
}

- (void)dealloc {
    [_fileHandle closeFile];
}


@end
