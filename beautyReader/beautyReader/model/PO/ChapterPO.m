//
//  ChapterPO.m
//  beautyReader
//
//  Created by superjoo on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChapterPO.h"
#import "CHAPTER.h"
#import "FileUtils.h"
#import "SENTENCE.h"
#import "WORD.h"

@interface ChapterPO()

//解析妙语
-(NSSet*) parseSentence:(CHAPTER*)chapter withContext:(NSManagedObjectContext*)context;

//解析单词
-(NSSet*) parseWord:(CHAPTER *)chapter withContext:(NSManagedObjectContext *)context;

@end

@implementation ChapterPO

@synthesize chapterName,title_en,title_zh,subject,chapterAudioUrl,chapter_en,chapter_zh,chapter_en_zh,chapter_sentence,chapter_words,sequence,comment;

+(ChapterPO*) parseChapter:(NSDictionary*)dictionary {
    ChapterPO *po = [[[ChapterPO alloc] init] autorelease];
    [po setValuesForKeysWithDictionary:dictionary];
    return po;
}

-(void) saveChapterPO:(NSManagedObjectContext*)context withId:(int)chapterId {
    NSError *error = nil;
    FileUtils *fileUtil = [FileUtils sharedFileUtils];
    CHAPTER *chapter = (CHAPTER*)[NSEntityDescription insertNewObjectForEntityForName:@"CHAPTER" inManagedObjectContext:context];
    chapter.chapterId = [NSNumber numberWithInt:chapterId];
    chapter.chapterName = self.chapterName;
    chapter.titleEn = self.title_en;
    chapter.titleZh = self.title_zh;
    chapter.subject = self.subject;
    chapter.chapterAudioUrl = self.chapterAudioUrl;
    //读取文章英文内容
    NSString *enFilePath = [fileUtil getAppFilePath:self.chapter_en suffix:@"txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:enFilePath]) {
        chapter.chapterEn = [NSData dataWithContentsOfFile:enFilePath];
    }
    //读取文章中文内容　
    NSString *zhFilePath = [fileUtil getAppFilePath:self.chapter_zh suffix:@"txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:zhFilePath]) {
        chapter.chapterZh = [NSData dataWithContentsOfFile:zhFilePath];
    }
    //读取文章中英文内容
    NSString *zhEnFilePath = [fileUtil getAppFilePath:self.chapter_en_zh suffix:@"txt"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:zhFilePath]) {
        chapter.chapterEnZh = [NSData dataWithContentsOfFile:zhEnFilePath];
    }
    chapter.createTime = [NSDate date];
    chapter.sequence = [NSNumber numberWithInt:[self.sequence intValue]];
    if ([self.sequence intValue] == 1) {//首个免费
        chapter.free = [NSNumber numberWithInt:1];
    } else {
        chapter.free = [NSNumber numberWithInt:0];
    }
    //妙语
    chapter.sentences = [self parseSentence:chapter withContext:context];
    //句子
    chapter.words = [self parseWord:chapter withContext:context];
    //游戏
    chapter.games = [NSSet set];
    if (![context save:&error]) {
        ELog(@"parse chapter error:%@",[error localizedDescription]);
    }
}

//解析妙语
-(NSSet*) parseSentence:(CHAPTER*)chapter withContext:(NSManagedObjectContext*)context {
    NSError *error = nil;
    NSMutableSet *retSet = [NSMutableSet set];
    FileUtils *fileUtil = [FileUtils sharedFileUtils];
    NSString *sentenceFilePath = [fileUtil getAppFilePath:self.chapter_sentence suffix:@"txt"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:sentenceFilePath]) {
        ELog(@"file not exist:%@",sentenceFilePath);
        return retSet;
    }
    NSString *sentence = [[NSString alloc] initWithContentsOfFile:sentenceFilePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        ELog(@"read sentence error:%@",sentenceFilePath);
        return retSet;
    }
    NSArray *paragraphs = [sentence componentsSeparatedByString:@"\n"];
    int senId = 1;
    for (int i = 0; i < [paragraphs count]; i+=2) {
        SENTENCE *sen = (SENTENCE*)[NSEntityDescription insertNewObjectForEntityForName:@"SENTENCE" inManagedObjectContext:context];
        sen.chapterId = chapter.chapterId;
        sen.sentenceId = [NSNumber numberWithInt:senId];
        sen.opTime = [NSDate date];
        sen.majorSentence = [NSNumber numberWithInt:0];
        sen.content = [paragraphs objectAtIndex:i];
        sen.translate = [paragraphs objectAtIndex:i+1];
        sen.chapter_s = chapter;
        [retSet addObject:sen];
        senId++;
    }
    return retSet;
}

//解析单词
-(NSSet*) parseWord:(CHAPTER *)chapter withContext:(NSManagedObjectContext *)context {
    NSError *error = nil;
    NSMutableSet *retSet = [NSMutableSet set];
    FileUtils *fileUtil = [FileUtils sharedFileUtils];
    NSString *wordFilePath = [fileUtil getAppFilePath:self.chapter_words suffix:@"txt"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:wordFilePath]) {
        ELog(@"file not exist:%@",wordFilePath);
        return retSet;
    }
    NSString *word = [[NSString alloc] initWithContentsOfFile:wordFilePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        ELog(@"read sentence error:%@",wordFilePath);
        return retSet;
    }
    NSArray *paragraphs = [word componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [paragraphs count]; i++) {
        WORD *wordObject = (WORD*)[NSEntityDescription insertNewObjectForEntityForName:@"WORD" inManagedObjectContext:context];
        wordObject.chapterId = chapter.chapterId;
        wordObject.content = [paragraphs objectAtIndex:i];
        wordObject.majorWord = [NSNumber numberWithInt:0];
        wordObject.opTime = [NSDate date];
        wordObject.wordId = [NSNumber numberWithInt:i];
        wordObject.chapter_w = chapter;
        [retSet addObject:wordObject];
    }
    return retSet;
}


-(void) dealloc {
    [chapterName release];
    [title_en release];
    [title_zh release];
    [subject release];
    [chapterAudioUrl release];
    [chapter_en release];
    [chapter_zh release];
    [chapter_en_zh release];
    [chapter_sentence release];
    [chapter_words release];
    [sequence release];
    [comment release];
    [super dealloc];
}

@end
