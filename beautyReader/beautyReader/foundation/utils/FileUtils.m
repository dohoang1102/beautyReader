//
//  FileUtils.m
//  mobileBank
//
//  Created by zhu zhanping on 11-11-02.
//  Copyright 2011__MyCompanyName__. All rights reserved.
//

#import "FileUtils.h"

static FileUtils *fileUtil = nil;
@implementation FileUtils

#pragma mark - sigleton
+(FileUtils*) sharedFileUtils {

    if (fileUtil == nil) {
        @synchronized(self) {
            if (fileUtil == nil) {
                fileUtil = [[self alloc] init];
            }
        }
    }
    return fileUtil;
}

+(id)allocWithZone:(NSZone *)zone {

    @synchronized(self) {
    
        if (fileUtil == nil) {
            fileUtil = [super allocWithZone:zone];
            return fileUtil;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    //denotes an object that cannot be released
    return UINT_MAX;  
}

- (id)autorelease
{
    return self;
}

/*
-(void) release {

    //do noting
}
 */

#pragma mark -
#pragma mark file utils method

-(NSString *) getDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

-(NSString*)getSandBoxFilePath :(NSString*)fileName {
    return [[self getDocumentPath] stringByAppendingPathComponent:fileName];
}

-(NSString *)getAppFilePath:(NSString*)fileName suffix:(NSString*)suffix {
   return [[NSBundle mainBundle] pathForResource:fileName ofType:suffix];
}

//设置用户标准文件数据
-(void) setUserDefaults:(id) object key:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//获取用户标准文件数据
-(id)getUserDefaultsForKey:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

//删除文件
-(void) deleteFile:(NSString*)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[self getSandBoxFilePath:fileName] error:nil];
}

//删除文件夹
-(BOOL) deleteFloder:(NSString*)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
   BOOL result = [fileManager removeItemAtPath:path error:&error];
    if (!result) {
        DBLog(@"删除文件夹失败,%@",[error localizedDescription]);
    }
    return result;
}

//获取本地文件或文件夹路径
-(NSString*) getFilePath:(NSString*)lastFolder {
    NSString *filePath = [[self getDocumentPath] stringByAppendingPathComponent:lastFolder];
    //判断本地缓存文件夹是否已创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}

//获取文件夹下所有文件
-(NSArray*) getSubFilesInFolder:(NSString*)folderPath {
    if (!folderPath || [@"" isEqualToString:folderPath]) {
        return nil;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) {
        DBLog(@"-->:%@　文件夹不存在",folderPath);
        return nil;
    }
    NSError *error = nil;
    NSArray *subFilesArray = [fileManager contentsOfDirectoryAtPath:folderPath error:&error];
    if (error) {
        DBLog(@"-->%@",[error localizedDescription]);
        return nil;
    }
    return subFilesArray;
}

//获取以参数为前缀的文件名
-(NSArray*) getSubFilesWithFilePerfix:(NSString *)perfix inFolder:(NSString*)folder {
    NSArray *array = [[NSBundle mainBundle] pathsForResourcesOfType:@"txt" inDirectory:folder];
    NSMutableArray *perfixArray = [NSMutableArray array];
    for (NSString *fileName in array) {
        if ([[fileName lastPathComponent] hasPrefix:perfix]) {
            [perfixArray addObject:fileName];
        }
    }
    return perfixArray;
}

//获取唯一标识主键
-(NSInteger) getUnitKey {
    if (!lock) {
        lock = [[NSCondition alloc] init];
    }
    [lock lock];
    int identifier = [[self getUserDefaultsForKey:kUnitKey] intValue];
    [self setUserDefaults:[NSNumber numberWithInt:identifier+1] key:kUnitKey];
    [lock unlock];
    DBLog(@"get unique key :%d",identifier);
    return identifier;
}

-(void) dealloc {
    [lock release];
    [super dealloc];
}

@end
