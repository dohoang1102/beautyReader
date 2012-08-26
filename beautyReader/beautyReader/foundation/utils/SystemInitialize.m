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
#import "CoreDataFactory.h"
#import "SUBJECT.h"
@interface SystemInitialize()
//初始化一级标题
-(BOOL) initMenu;

@end

static int seqence = 1;

@implementation SystemInitialize

//初始化
-(BOOL) initialize {
    //初始化一级菜单
    if (![self initMenu]) {
        return NO;
    }
    //解析并初始化春季篇文章
    BOOL parseSpring = [self parseChapters:@"spring"];
    if (!parseSpring) {
        return NO;
    }
    
    //解析并初始化夏季篇文章
    BOOL parseSummer = [self parseChapters:@"summer"];
    if (!parseSummer) {
        return NO;
    }
    //解析并初始化秋季篇文章
    BOOL parseAutumn = [self parseChapters:@"autumn"];
    if (!parseAutumn) {
        return NO;
    }
    //解析并初始化冬季篇文章
    BOOL parseWinter = [self parseChapters:@"winter"];
    if (!parseWinter) {
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
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    
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
        [chapter saveChapterPO:context withId:seqence];
        seqence ++;
    }
    
    return YES;
}

//初始化一级标题
-(BOOL) initMenu {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    //----------------------春---------------------------
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:1];
        subject.subjectType = [NSNumber numberWithInt:1];
        subject.subjectName = @"Working Tips";
        subject.subjectTranslation = @"求职贴士篇";
        subject.subjectInfo = @"Day 001 – Day 030";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:2];
        subject.subjectType = [NSNumber numberWithInt:1];
        subject.subjectName = @"Workint Tips";
        subject.subjectTranslation = @"求职贴士篇";
        subject.subjectInfo = @"Day 031 – Day 040";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:3];
        subject.subjectType = [NSNumber numberWithInt:1];
        subject.subjectName = @"Working Tips";
        subject.subjectTranslation = @"求职贴士篇";
        subject.subjectInfo = @"Day 041 – Day065";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:4];
        subject.subjectType = [NSNumber numberWithInt:1];
        subject.subjectName = @"Working Tips";
        subject.subjectTranslation = @"求职贴士篇";
        subject.subjectInfo = @"Day 066 – Day 092";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    //---------------------夏---------------------------------
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:5];
        subject.subjectType = [NSNumber numberWithInt:2];
        subject.subjectName = @"Meditation";
        subject.subjectTranslation = @"涤荡心灵篇";
        subject.subjectInfo = @"Day 093 – Day 114";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:6];
        subject.subjectType = [NSNumber numberWithInt:2];
        subject.subjectName = @"Meditation";
        subject.subjectTranslation = @"涤荡心灵篇";
        subject.subjectInfo = @"Day 115 – Day 136";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:7];
        subject.subjectType = [NSNumber numberWithInt:2];
        subject.subjectName = @"Meditation";
        subject.subjectTranslation = @"涤荡心灵篇";
        subject.subjectInfo = @"Day 137 – Day158";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:8];
        subject.subjectType = [NSNumber numberWithInt:2];
        subject.subjectName = @"Meditation";
        subject.subjectTranslation = @"涤荡心灵篇";
        subject.subjectInfo = @"Day 159 – Day 179";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    //----------------------------秋---------------------------
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:9];
        subject.subjectType = [NSNumber numberWithInt:3];
        subject.subjectName = @"Drops of Happiness";
        subject.subjectTranslation = @"幸福点滴篇";
        subject.subjectInfo = @"Day 093 – Day 114";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:10];
        subject.subjectType = [NSNumber numberWithInt:3];
        subject.subjectName = @"Drops of Happiness";
        subject.subjectTranslation = @"幸福点滴篇";
        subject.subjectInfo = @"Day 115 – Day 136";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:11];
        subject.subjectType = [NSNumber numberWithInt:3];
        subject.subjectName = @"Drops of Happiness";
        subject.subjectTranslation = @"幸福点滴篇";
        subject.subjectInfo = @"Day 137 – Day158";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:12];
        subject.subjectType = [NSNumber numberWithInt:3];
        subject.subjectName = @"Drops of Happiness";
        subject.subjectTranslation = @"幸福点滴篇";
        subject.subjectInfo = @"Day 159 – Day 179";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    //----------------------------冬---------------------------
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:13];
        subject.subjectType = [NSNumber numberWithInt:4];
        subject.subjectName = @"Casual Wandering";
        subject.subjectTranslation = @"漫步人生篇";
        subject.subjectInfo = @"Day 093 – Day 114";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:14];
        subject.subjectType = [NSNumber numberWithInt:4];
        subject.subjectName = @"Casual Wandering";
        subject.subjectTranslation = @"漫步人生篇";
        subject.subjectInfo = @"Day 115 – Day 136";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:15];
        subject.subjectType = [NSNumber numberWithInt:4];
        subject.subjectName = @"Casual Wandering";
        subject.subjectTranslation = @"漫步人生篇";
        subject.subjectInfo = @"Day 137 – Day158";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    {
        SUBJECT *subject = (SUBJECT*)[NSEntityDescription insertNewObjectForEntityForName:@"SUBJECT" inManagedObjectContext:context];
        subject.sequence = [NSNumber numberWithInt:16];
        subject.subjectType = [NSNumber numberWithInt:4];
        subject.subjectName = @"Casual Wandering";
        subject.subjectTranslation = @"漫步人生篇";
        subject.subjectInfo = @"Day 159 – Day 179";
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@",[error localizedDescription]);
            return NO;
        }
    }
    return YES;
}

@end
