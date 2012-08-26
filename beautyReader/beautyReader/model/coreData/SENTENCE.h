//
//  SENTENCE.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CHAPTER;

@interface SENTENCE : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterId;//文章ID
@property (nonatomic, retain) NSNumber * sentenceId;//句子ID
@property (nonatomic, retain) NSDate * opTime;//操作时间
@property (nonatomic, retain) NSNumber * majorSentence;//是否收藏　
@property (nonatomic, retain) NSString * content;//句子内容
@property (nonatomic, retain) NSString * translate;//句子翻译
@property (nonatomic, retain) CHAPTER *chapter_s;//关联文章

@end
