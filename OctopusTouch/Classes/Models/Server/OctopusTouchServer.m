//
//  OctopusTouchServer.m
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "OctopusTouchServer.h"
#import "GCDWebServer.h"

#import "GCDWebServerDataRequest.h"
#import "GCDWebServerURLEncodedFormRequest.h"
#import "GCDWebServerMultiPartFormRequest.h"

#import "GCDWebServerDataResponse.h"
#import "GCDWebServerStreamedResponse.h"
#import "CommandMananger.h"

@implementation OctopusTouchServer

static OctopusTouchServer* _sharedInstance = nil;

+(OctopusTouchServer*)sharedInstance{
    if(!_sharedInstance){
        _sharedInstance = [[OctopusTouchServer alloc] init];
    }
    return _sharedInstance;
}

- (void)setup:(NSString*)rootDirectory {
    [self addGETHandlerForBasePath:@"/" directoryPath:rootDirectory indexFilename:@"index.html" cacheAge:0 allowRangeRequests:YES];
    //@step
    //__weak __typeof(self)weakSelf = self;
    [self addDefaultHandlerForMethod:@"POST"
                             requestClass:[GCDWebServerURLEncodedFormRequest class]
                             processBlock:^GCDWebServerResponse*(GCDWebServerRequest* request) {
                                // __strong __typeof(weakSelf)strongSelf = weakSelf;
                               OctopusTouchServer*  strongSelf = [OctopusTouchServer sharedInstance];
                                 return  [strongSelf onRequest:request];
                                 
                             }];
}

- (GCDWebServerResponse*)onRequest:(GCDWebServerRequest* ) request ;{
    
    [[CommandMananger sharedInstance]onRequest:request];
    
    NSDictionary* json = [NSDictionary dictionaryWithObject:@"ACK" forKey:@"result"];
    return  [GCDWebServerDataResponse responseWithJSONObject:  json];
    
    return [GCDWebServerDataResponse responseWithHTML:@"<html><body><p>Hello Touch World</p></body></html>"];
}

@end
