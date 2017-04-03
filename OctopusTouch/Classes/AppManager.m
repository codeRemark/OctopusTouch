//
//  AppManager.m
//  OctopusTouch
//
//  Created by icoco7 on 30/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "AppManager.h"
#import "WebServer.h"
#import "FileHelper.h"
#import "ResourceHelper.h"

@interface AppManager (){
    NSString* _serverRootPath;
}

@end

@implementation AppManager

static AppManager* _sharedInstance = nil;

+(AppManager*)sharedInstance{
    if(!_sharedInstance){
        _sharedInstance = [[AppManager alloc] init];
    }
    return _sharedInstance;
}

- (void)controlWebServer:(BOOL)shouldRun{
    if (shouldRun){
        [[WebServer sharedInstance]start];
        return ;
    }
    [[WebServer sharedInstance]stop];
}

- (void)setupSpace{
    
    NSURL* folder = [Resources getAppDocumentDirectory];
    NSString* source = @"Site";
    NSURL* target_U = [folder URLByAppendingPathComponent:source];
    NSString* target = [target_U path];
    
    NSLog(@"target=%@",target);
#ifdef DEBUG
    [[FileHelper sharedManager]deleteDir:target];
#endif
    if (![[FileHelper sharedManager]existsDir:target]){
      //  [[FileHelper sharedManager] createDir:target];
        
    }
    //@step
    target = [ResourceHelper mapShandboxPath2Disk:target];
    _serverRootPath = target;
    
    [ResourceHelper copyBundleFile:source targetPath:target];
    
}

- (NSString*)getServerRootPath{
    return _serverRootPath ;
}

@end
