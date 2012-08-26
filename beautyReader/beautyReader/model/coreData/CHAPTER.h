//
//  CHAPTER.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GAME, SENTENCE, WORD;

@interface CHAPTER : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterId;//ID
@property (nonatomic, retain) NSString * chapterName;//名称(如：Day001)
@property (nonatomic, retain) NSString * titleEn;//英文标题
@property (nonatomic, retain) NSString * titleZh;//中文标题
@property (nonatomic, retain) NSString * subject;//所属一级标题中文名
@property (nonatomic, retain) NSString * chapterAudioUrl;//音频文件名(不带后缀)
@property (nonatomic, retain) NSData * chapterEn;//英文内容
@property (nonatomic, retain) NSData * chapterZh;//中文内容
@property (nonatomic, retain) NSData * chapterEnZh;//中英文内容
@property (nonatomic, retain) NSNumber * sequence;//序列号
@property (nonatomic, retain) NSDate * createTime;//创建时间
@property (nonatomic, retain) NSSet *sentences;//妙语集合
@property (nonatomic, retain) NSSet *words;//单词集合
@property (nonatomic, retain) NSNumber *free;//是否收费
@property (nonatomic, retain) NSSet *games;//游戏集合
@end


@interface CHAPTER (CoreDataGeneratedAccessors)

- (void)addGamesObject:(GAME *)value;
- (void)removeGamesObject:(GAME *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

- (void)addSentencesObject:(SENTENCE *)value;
- (void)removeSentencesObject:(SENTENCE *)value;
- (void)addSentences:(NSSet *)values;
- (void)removeSentences:(NSSet *)values;

- (void)addWordsObject:(WORD *)value;
- (void)removeWordsObject:(WORD *)value;
- (void)addWords:(NSSet *)values;
- (void)removeWords:(NSSet *)values;

@end
