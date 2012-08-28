//
//  ChapterService.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUBJECT;
@class CHAPTER;
@class WORD;
@interface ChapterService : NSObject

//查询二级标题下的文章列表
-(NSArray*) queryChaptersWithSubject:(SUBJECT*)subject;

//查询重点词汇
-(NSArray*) queryWordsWithChapter:(CHAPTER*)chapter;

//更新重点词汇
-(BOOL) updateWords:(WORD*)word;

@end
