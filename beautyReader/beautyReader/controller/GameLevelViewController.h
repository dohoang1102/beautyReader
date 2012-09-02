//
//  GameLevelViewController.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAPTER;
@class GAME;
@interface GameLevelViewController : UIViewController {
    CHAPTER *chapter;
}

@property (nonatomic,retain) CHAPTER *chapter;

-(GAME*) gameLevelRecord:(int)level;

-(void) goBack;

-(void) gameStartLevel:(int)level;

@end
