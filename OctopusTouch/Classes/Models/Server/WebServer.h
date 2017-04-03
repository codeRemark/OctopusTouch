//
//  WebServer.h
//  GCDWebServer
//
//  Created by Coco.

//

#import <Foundation/Foundation.h>

@interface WebServer : NSObject

+(WebServer*)sharedInstance;

- (BOOL)isRunning;

- (void)start;

- (void)stop;

- (NSString*)getServerRootPath;

@end
