//
//  SystemInitialize.m
//  beautyReader
//
//  Created by superjoo on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SystemInitialize.h"
#import "XMLParseFactory.h"
#import "ChapterPO.h"

@implementation SystemInitialize

//初始化
-(BOOL) initialize {
    BOOL parseSpring = [self parseChapters:@"spring"];
    if (!parseSpring) {
        return NO;
    }
    return YES;
}

//解析配置文件
-(BOOL) parseChapters:(NSString*)chapterFileUrl {
    if (!chapterFileUrl) {
        return NO;
    }
    NSError *error = nil;
    FileUtils *fileUtil = [FileUtils sharedFileUtils];
    NSString *bookSrcFilepath = [fileUtil getAppFilePath:chapterFileUrl suffix:@"xml"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:bookSrcFilepath]) {
        DBLog(@"error: parse chapter list error,%@ not exist",chapterFileUrl);
        return NO;
    }
    NSString *fileContent =  [[NSString alloc] initWithContentsOfFile:bookSrcFilepath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        DBLog(@"error: read chapter configuration error,%@ not exist",chapterFileUrl);
        return NO;
    }
    XMLParseFactory *xmlParser = [[[XMLParseFactory alloc] init] autorelease];
    NSArray *chapterList = [xmlParser parseXMLOfString:fileContent];
    for (NSDictionary *dictionary in chapterList) {
        ChapterPO *chapter = [ChapterPO parseChapter:[dictionary objectForKey:@"chapter"]];
        DBLog(@"...... chapterName:%@ ",chapter.chapter_en);
    }
    
    return YES;
}


@end
