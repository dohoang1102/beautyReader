//
//  GameSecondLevelViewController.h
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameResultView.h"
#import "GamePauseView.h"

@class CHAPTER;
@interface GameSecondLevelViewController : UIViewController<UIAlertViewDelegate,GameResultDelegate,GamePauseDelegate> {
    CHAPTER *chapter;
    int totalTime;//第一关游戏总时间
    NSTimer *gameTimer;//游戏
    GameResultView *resultView;
    GamePauseView *pauseView;
    BOOL timerStarted;
}

@property (nonatomic,retain) CHAPTER *chapter;
@property (nonatomic,assign) int totalTime;

-(void) showGameResult;

-(void) pauseGame;

@end
