//
//  GameSecondLevelView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *SeGameReadyNotification;//游戏准备开始通知

@class CardView;
@class GameSecondLevelViewController;
@class FXLabel;
@interface GameSecondLevelView : UIView {
    CardView *card1;
    CardView *card2;
    CardView *card3;
    CardView *card4;
    CardView *card5;
    CardView *card6;
    CardView *card7;
    CardView *card8;
    int cardCount;
    NSTimer *initialTimer;//发牌计时器
    NSTimer *mixUpOrderTimer;//发牌后打乱顺序定时器
    GameSecondLevelViewController *controller;
    float mixUpTime;
    NSMutableArray *cardPositionArray;
    FXLabel *totalTimeLabel;
    CardView *lastOpenCard;//最近一次翻开的卡片
    int disapparCard;//已经移除的卡片
}

@property (nonatomic,assign) GameSecondLevelViewController *controller;
@property (nonatomic,assign) FXLabel *totalTimeLabel;

//发牌
-(void) showCardWithAnimation;

//更新定时器
-(void) updateTimerLabel;

//翻牌
-(void) takeOverAllCards;

-(void) pauseTimer;

-(void) resumeTimer;

@end
