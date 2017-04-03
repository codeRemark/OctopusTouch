//
//  Resources.h
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const kServerEvent = @"kServerEvent";

@interface Resources : NSObject

+ (NSString*)getServiceName;

+ (NSString*)getServerPort;

+ (void)setServerPort:(NSString*)port;

+ (NSString*)getMasterName;

+ (NSString*)getAccessToken;

+ (void)setAccessToken:(NSString*)token;

+ (void)setServerURL:(NSURL*)url;

+ (NSString*)getServerURLString;

+ (NSImage*)getServerURLAsQRImage;

+ (NSURL*)getAppDocumentDirectory;
@end
