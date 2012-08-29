//
//  FileUtils.h
//  mobileBank
//  文件操作工具类
//  Created by zhu zhanping on 11-11-02.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *SubjectNotification;//主题更新通知

#define kInitFileFolder         @"initTmp"
#define kUnitKey                @"uKeys"
#define FIRST_INSTALL           @"firstInstall"
#define Skin                    @"SkinPackage"

#define DATABASE_NAME           @"sql.sqlite"
@interface FileUtils : NSObject {
    NSCondition *lock;
}

+(FileUtils*) sharedFileUtils;

#pragma mark -
#pragma mark 沙盒文件操作
//获取document路径
-(NSString *) getDocumentPath;

//获取沙盒中文件路径
-(NSString*)getSandBoxFilePath :(NSString*)fileName;

#pragma mark -
#pragma mark APP应用中文件操作
//获取APP中文件路径
-(NSString *)getAppFilePath:(NSString*)fileName suffix:(NSString*)suffix;

//设置用户标准文件数据
-(void) setUserDefaults:(id) object key:(NSString*)key;

//获取用户标准文件数据
-(id)getUserDefaultsForKey:(NSString*)key;

//删除文件
-(void) deleteFile:(NSString*)fileName;

//删除文件夹
-(BOOL) deleteFloder:(NSString*)path;

//获取本地文件路径
-(NSString*) getFilePath:(NSString*)lastFolder;

//获取文件夹下所有文件
-(NSArray*) getSubFilesInFolder:(NSString*)folderPath;

//获取以参数为前缀的文件名
-(NSArray*) getSubFilesWithFilePerfix:(NSString *)perfix inFolder:(NSString*)folder;

//获取唯一标识主键
-(NSInteger) getUnitKey; 

@end
