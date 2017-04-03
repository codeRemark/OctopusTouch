//
//  ResourceHelper.h
//  OctopusTouch
//
//  Created by icoco7 on 30/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourceHelper : NSObject

+ (BOOL)copyBundleFile:(NSString*)sourcePath targetPath:(NSString*)targetPath;

+ (NSString*)mapShandboxPath2Disk:(NSString*)path;

@end
