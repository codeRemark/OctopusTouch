//
//  Resources.m
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "Resources.h"
#import "QRCodeHelper.h"
#import "FileHelper.h"

#define kServerPort @"ServerPort"
#define kAccessToken @"AccessToken"

@implementation Resources

+ (NSString*)getServiceName{
    
    return  @"Octopus Touch";
}

+ (NSString*)getServerPort{
   
    return  AppResourceGet(kServerPort, @"8668"); //deafult
}

+ (void)setServerPort:(NSString*)port{
    AppResourceSet(kServerPort, port);
}

+ (NSString*)getMasterName{
    return  @"master";
}


+ (NSString*)getAccessToken{
    return  AppResourceGet(kAccessToken, @"touchMac");//default
}

+ (void)setAccessToken:(NSString*)token{
    AppResourceSet(kAccessToken, token);
}

static NSString* _serverURL = @"";
+ (NSString*)getServerURLString{
    return _serverURL;
}

+ (void)setServerURL:(NSURL*)url{
    _serverURL = [NSString stringWithFormat:@"%@", url];
}

+ (NSImage*)getServerURLAsQRImage{
    NSString* url = [Resources getServerURLString];
    if (nil == url || [url length]<=0){
        return nil;
    }
    return [QRCodeHelper generate:url];
}


+ (NSURL*)getAppDocumentDirectory{

    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:NSDocumentationDirectory
                                             inDomains:NSLocalDomainMask];
    NSURL* appSupportDir = nil;
    NSURL* appDirectory = nil;
    
    if ([possibleURLs count] >= 1) {
        // Use the first directory (if multiple are returned)
        appSupportDir = [possibleURLs objectAtIndex:0];
    }
    
    // If a valid app support directory exists, add the
    // app's bundle ID to it to specify the final directory.
    if (appSupportDir) {
        NSString* folder = [appSupportDir path];
        if (![[FileHelper sharedManager]existsDir:folder]){
            [[FileHelper sharedManager] createDir:folder];
        }
        
      //  NSString* appBundleID = [[NSBundle mainBundle] bundleIdentifier];
     //   appDirectory = [appSupportDir URLByAppendingPathComponent:appBundleID];
    }
    
    appDirectory = appSupportDir;
    
    NSString* folder = [appDirectory path];
    if (![[FileHelper sharedManager]existsDir:folder]){
         [[FileHelper sharedManager] createDir:folder];
    }
    return appDirectory;
 }

@end
