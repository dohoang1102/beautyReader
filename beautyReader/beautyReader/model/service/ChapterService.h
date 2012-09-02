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
@class SENTENCE;
@interface ChapterService : NSObject

//查询二级标题下的文章列表
-(NSArray*) queryChaptersWithSubject:(SUBJECT*)subject;

//查询重点词汇
-(NSArray*) queryWordsWithChapter:(CHAPTER*)chapter;

//更新重点词汇
-(BOOL) updateWords:(WORD*)word;

//更新妙句
-(BOOL) updateSentence:(SENTENCE*)sentence;

//更新文章
-(BOOL) updateChapter:(CHAPTER*)chapter;

//查询已收藏的重点词汇
-(NSArray*) queryFavoritesWords;

//查询已收藏的妙句
-(NSArray*) queryFavoritesSentences;

//根据ID查询文章
-(CHAPTER*) queryChapterWithId:(int) chapterId;

//更新游戏分数
-(BOOL) updateGameScore:(NSNumber*)chapterId level:(int)level time:(int)gameTimes score:(int) score;

@end
