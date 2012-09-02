//
//  GAME.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CHAPTER;

@interface GAME : NSManagedObject

@property (nonatomic, retain) NSNumber * chapterId;//文章ID
@property (nonatomic, retain) NSNumber * level;//游戏关数 1 2 3分别代表第一关第二关第三关
@property (nonatomic, retain) NSNumber * score;//游戏得分数
@property (nonatomic, retain) NSNumber * time;//游戏时间
@property (nonatomic, retain) CHAPTER *chapter_g;

@end
