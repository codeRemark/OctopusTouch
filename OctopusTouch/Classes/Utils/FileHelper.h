//
//  FileHelper.h
//  file
//
//  Created by youtubek on 2016/07/19.
//  Copyright © 2016年 youtubek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHelper : NSObject{
    NSMutableArray* _items;
}

+(FileHelper*)sharedManager;

@property (nonatomic, retain) NSFileManager* fm;
@property (nonatomic, readonly) NSMutableArray* items;

- (BOOL)existsFile:(NSString*)fileName dir:(NSString*)dirName;
- (BOOL)removeFile:(NSString*)fileName dir:(NSString*)dirName;
- (BOOL)createFile:(NSString*)fileName dir:(NSString*)dirName data:(NSData*)data;
-(NSMutableArray*)listFiles:(NSString*)dirName;

- (BOOL)existsDir:(NSString*)dirName;
- (BOOL)createDir:(NSString*)dirName;
- (BOOL)moveDir:(NSString*)fromDir to:(NSString*)toDir;
- (BOOL)copyDir:(NSString*)fromDir to:(NSString*)toDir;
- (BOOL)deleteDir:(NSString*)dirName;
-(NSMutableArray*)listDirs;
-(BOOL)removeAllDir;

+ (NSString*)getDoucumentPath;

- (BOOL)writeFileInDocument:(NSString*)fileName data:(NSData*)data;

- (BOOL)copyFileToDocument:(NSString*)srcFileName targtFileName:(NSString*)targtFileName;

@end
