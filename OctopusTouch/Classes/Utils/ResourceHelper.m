//
//  ResourceHelper.m
//  OctopusTouch
//
//  Created by icoco7 on 30/03/2017.
//  Copyright © 2017 icoco. All rights reserved.
//

#import "ResourceHelper.h"
#import "FileHelper.h"

@implementation ResourceHelper


+ (BOOL)copyBundleFile:(NSString*)sourcePath targetPath:(NSString*)targetPath{
    NSBundle *thisBundle = [NSBundle mainBundle];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:targetPath] == NO) {    [fileManager createDirectoryAtPath:targetPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    
    NSString* srcPath = [thisBundle pathForResource:sourcePath ofType:nil];
    NSLog(@"srcPath=%@,targetPath=%@",srcPath,targetPath);
    
    NSError* error ;
    [fileManager copyItemAtPath: srcPath toPath:targetPath error:&error];
    if (error){
        NSLog(@"error:%@",error);
    }
    return nil == error;
}

+ (NSString*)mapShandboxPath2Disk:(NSString*)path{
     NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
      NSString *dir = [docPath stringByAppendingPathComponent:path];
    return dir;
}

@end
