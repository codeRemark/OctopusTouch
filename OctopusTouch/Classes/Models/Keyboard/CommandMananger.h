//
//  CommandMananger.h
//  OctopusTouch
//
//  Created by icoco.
//

#import <Foundation/Foundation.h>
#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"

static NSString* const kFunctionKey = @"functionKey";
static NSString* const kPlainKey = @"plainKey";
static NSString* const kContentKey = @"content";
static NSString* const kSysEventCode = @"sysEventCode";
static NSString* const kSysEventParams = @"sysEventParams";

@interface CommandMananger : NSObject

+(CommandMananger*)sharedInstance;

- (void) onRequest:(GCDWebServerRequest* ) request;

@end
