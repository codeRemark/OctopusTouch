//
//  FileHelper.m
//  file
//
//  Created by youtubek on 2016/07/19.
//  Copyright © 2016年 youtubek. All rights reserved.
//

#import "FileHelper.h"

@implementation FileHelper
@synthesize items = _items;
static FileHelper* _sharedInstance = nil;

+(FileHelper*)sharedManager{
    if(!_sharedInstance){
        _sharedInstance = [[FileHelper alloc] init];
    }
    return _sharedInstance;
}

- (id)init{
    
    self = [super init];
    if (!self) {
        return nil;
    }
    self.fm = [NSFileManager defaultManager];
    _items = [NSMutableArray array];
    return self;
}


// ファイル存在チェック
- (BOOL)existsFile:(NSString*)fileName dir:(NSString*)dirName{
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *dirPath = @"";
    NSString *filePath = @"";
    
    if(![dirName isEqualToString:@""]){
        dirPath = [docPath stringByAppendingPathComponent:dirName];
        filePath = [dirPath stringByAppendingPathComponent:fileName];
    }else{
        filePath = [docPath stringByAppendingPathComponent:fileName];
    }
    return [self.fm fileExistsAtPath:filePath];
}

// ファイル削除
- (BOOL)removeFile:(NSString*)fileName dir:(NSString*)dirName{
    NSError *error;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *dirPath = @"";
    NSString *filePath = @"";
    
    if(![dirName isEqualToString:@""]){
        dirPath = [docPath stringByAppendingPathComponent:dirName];
        filePath = [dirPath stringByAppendingPathComponent:fileName];
    }else{
        filePath = [docPath stringByAppendingPathComponent:fileName];
    }
    [self.fm removeItemAtPath:filePath error:&error];
    [self listFiles:@""];
    if(error != nil){
        return NO;
    }else{
        return YES;
    }
}

// ファイル作成
- (BOOL)createFile:(NSString*)fileName dir:(NSString*)dirName data:(NSData*)data{
    
    BOOL flag = NO;
    [self createDir:dirName];

    NSError *error;
    NSString *dirPath = @"";
    NSString *filePath = @"";
    
    // ファイルが存在していれば削除
    if([self existsFile:fileName dir:dirName]){
        [self removeFile:fileName dir:dirName];
    }
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if(![dirName isEqualToString:@""]){
        dirPath = [docPath stringByAppendingPathComponent:dirName];
        filePath = [dirPath stringByAppendingPathComponent:fileName];
    }else{
        filePath = [docPath stringByAppendingPathComponent:fileName];
    }
    NSLog(@"filePath %@",filePath);
    // attributesはNSDictionaryで保存
    flag = [self.fm createFileAtPath:filePath contents:data attributes:nil];
    [self listFiles:@""];
    if(flag){
        return YES;
    }else{
        return NO;
    }
    
}


// ファイル一覧
-(NSMutableArray*)listFiles:(NSString*)dirName{
    NSError *error;
    NSMutableArray* arr = [NSMutableArray array];
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *paths = [self.fm contentsOfDirectoryAtPath:docPath error:&error];
    BOOL isDir = NO;
    //NSLog(@"path count %lu",(unsigned long)[paths count]);
    for (NSString *path in paths) {
        NSString *dir = [docPath stringByAppendingPathComponent:path];
        if ([self.fm fileExistsAtPath:dir isDirectory:&isDir] && isDir && ([dirName isEqualToString:@""] || [dirName isEqualToString:dirName])) {
 
            // ディレクトリ内ファイル一覧
            NSArray *files = [self.fm contentsOfDirectoryAtPath:dir error:&error];
            for(NSString *file in files) {
                NSString *file2 = [dir stringByAppendingPathComponent:file];
                NSLog(@"file %@",file2);
                NSLog(@"拡張子 %@",[file pathExtension]);
                [arr addObject:file2];
            }
        }
    }
    _items = arr;
    return arr;
    
}


// ディレクトリー存在チェック
- (BOOL)existsDir:(NSString*)dirName{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dir = [docPath stringByAppendingPathComponent:dirName];
    return [self.fm fileExistsAtPath:dir];
}


// ディレクトリー作成
- (BOOL)createDir:(NSString*)dirName{
    
    BOOL flag = NO;
    if(![self existsDir:dirName]){
        NSError *error;
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dir = [docPath stringByAppendingPathComponent:dirName];
        [self.fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
        
        if(error != nil){
            flag = NO;
        }else{
            flag = YES;
        }
    }else{
        flag = YES;
    }
    NSLog(@"createDir %@, flag:%d",dirName, flag);
    return flag;

}

// ディレクトリー移動
- (BOOL)moveDir:(NSString*)fromDir to:(NSString*)toDir{
    NSError *error;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *dir = [docPath stringByAppendingPathComponent:fromDir];
    
    NSString *dir2 = [docPath stringByAppendingPathComponent:toDir];
    [self.fm moveItemAtPath:dir toPath:dir2 error:&error];
    
    if(error != nil){
        return NO;
    }else{
        return YES;
    }
}

// ディレクトリーコピー
- (BOOL)copyDir:(NSString*)fromDir to:(NSString*)toDir{
    NSError *error;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *dir = [docPath stringByAppendingPathComponent:fromDir];
    
    NSString *dir2 = [docPath stringByAppendingPathComponent:toDir];
    [self.fm copyItemAtPath:dir toPath:dir2 error:&error];
    
    if(error != nil){
        return NO;
    }else{
        return YES;
    }
}

// ディレクトリー削除
- (BOOL)deleteDir:(NSString*)dirName{
    NSError *error;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *dir = [docPath stringByAppendingPathComponent:dirName];
    [self.fm removeItemAtPath:dir error:&error];
    
    if(error != nil){
        return NO;
    }else{
        return YES;
    }
    
}

// ディレクトリ一覧
-(NSMutableArray*)listDirs{
    NSError *error;
    NSMutableArray* arr = [NSMutableArray array];

    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *paths = [self.fm contentsOfDirectoryAtPath:docPath error:&error];
    BOOL isDir = NO;
    //NSLog(@"path count %lu",(unsigned long)[paths count]);
    for (NSString *path in paths) {
        NSString *dir = [docPath stringByAppendingPathComponent:path];
        if ([self.fm fileExistsAtPath:dir isDirectory:&isDir] && isDir) {
            // path is directory
            NSLog(@"path %@",dir);
            [arr addObject:dir];
       }
    }
    return arr;

}

// ディレクトリー全削除
-(BOOL)removeAllDir{

    NSError *error;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    NSArray *paths = [self.fm contentsOfDirectoryAtPath:docPath error:nil];
    BOOL isDir = NO;
    //NSLog(@"path count %lu",(unsigned long)[paths count]);
    for (NSString *path in paths) {
        NSString *dir2 = [docPath stringByAppendingPathComponent:path];
        if ([self.fm fileExistsAtPath:dir2 isDirectory:&isDir] && isDir) {
            // path is directory
            NSLog(@"path %@",dir2);
            [self.fm removeItemAtPath:dir2 error:&error];
        }
    }
    if(error != nil){
        return YES;
    }else{
        return NO;
    }
 
}

-(void)loadObj:(NSString*)fileName dir:(NSString*)dirName{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *dirPath = @"";
    NSString *filePath = @"";
    
    if(![dirName isEqualToString:@""]){
        dirPath = [docPath stringByAppendingPathComponent:fileName];
        filePath = [dirPath stringByAppendingPathComponent:fileName];
    }else{
        filePath = [docPath stringByAppendingPathComponent:fileName];
    }
    
    NSMutableArray* items = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    _items = items;
    
}


-(BOOL)saveObj:(NSString*)fileName dir:(NSString*)dirName{

    if(![dirName isEqualToString:@""]){
        [self createDir:dirName];
    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
    BOOL flag = [NSKeyedArchiver archiveRootObject:_items toFile:filePath];
    
    if(flag){
        return YES;
    }else{
        return NO;
    }
}

+ (NSString*)getDoucumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (BOOL)writeFileInDocument:(NSString*)fileName data:(NSData*)data;{
    NSString *documentsDirectory = [FileHelper getDoucumentPath];
    return [self createFile:fileName dir:documentsDirectory data:data];
}

- (BOOL)copyFileToDocument:(NSString*)srcFileName targtFileName:(NSString*)targtFileName{
    
    NSData* data = [NSData dataWithContentsOfFile:srcFileName];
    NSString *documentsDirectory = [FileHelper getDoucumentPath];
    return [self createFile:targtFileName dir:documentsDirectory data:data];
}


@end
