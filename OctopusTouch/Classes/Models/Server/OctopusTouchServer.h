//
//  OctopusTouchServer.h
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "GCDWebServer.h"

@interface OctopusTouchServer : GCDWebServer

+(OctopusTouchServer*)sharedInstance;

- (void)setup:(NSString*)rootDirectory;

- (GCDWebServerResponse*)onRequest:(GCDWebServerRequest* ) request ;

@end
