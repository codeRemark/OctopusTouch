//
//  OctopusTouch_pre.h
//  OctopusTouch
//
//  Created by icoco7 on 19/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG

#define NSLog(format, ...) NSLog(@"file:%s,line:%d,%s:%@",__FILE__, __LINE__, __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);

#else
#define NSLog(...) {}
#endif

#import "AppResource.h"

#import "Resources.h"

#import "AppManager.h"
