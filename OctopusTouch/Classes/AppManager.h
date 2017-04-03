//
//  AppManager.h
//  OctopusTouch
//
//  Created by icoco7 on 30/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

+ (AppManager*)sharedInstance;

- (void)setupSpace;

- (void)controlWebServer:(BOOL)shouldRun;

- (NSString*)getServerRootPath;

@end
