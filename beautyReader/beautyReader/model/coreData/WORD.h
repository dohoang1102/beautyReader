//
//  WORD.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CHAPTER;

@interface WORD : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterId;//文章ID
@property (nonatomic, retain) NSString * content;//单词内容
@property (nonatomic, retain) NSNumber * majorWord;//是否标注已收藏
@property (nonatomic, retain) NSDate * opTime;//操作时间
@property (nonatomic, retain) NSNumber * wordId;//单词ID
@property (nonatomic, retain) CHAPTER *chapter_w;

@end
