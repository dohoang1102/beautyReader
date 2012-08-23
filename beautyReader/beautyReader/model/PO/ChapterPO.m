//
//  ChapterPO.m
//  beautyReader
//
//  Created by superjoo on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChapterPO.h"

@implementation ChapterPO

@synthesize chapterName,title_en,title_zh,subject,chapterAudioUrl,chapter_en,chapter_zh,chapter_en_zh,chapter_sentence,chapter_words,sequence,comment;

+(ChapterPO*) parseChapter:(NSDictionary*)dictionary {
    ChapterPO *po = [[[ChapterPO alloc] init] autorelease];
    [po setValuesForKeysWithDictionary:dictionary];
    return po;
}

@end
