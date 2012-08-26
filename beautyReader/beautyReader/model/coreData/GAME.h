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

@property (nonatomic, retain) NSNumber * chapterId;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSNumber * time;
@property (nonatomic, retain) CHAPTER *chapter_g;

@end
