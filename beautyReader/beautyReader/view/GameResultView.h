//
//  GameResultView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GameResultDelegate;

@interface GameResultView : UIView {
    int resultLevel;//得分星级
    BOOL hasNextLevel;//是否含有下一关
    UILabel *levelInfoLevel;//本关得分
    UIImageView *scoreImageView;//得分星级
    UIButton *replayBtn;
    UIButton *nextLevelBtn;
    UIButton *chooseLevelBtn;
    id<GameResultDelegate> delegate;
}

@property (nonatomic,assign) int resultLevel;
@property (nonatomic,assign) BOOL hasNextLevel;
@property (nonatomic,assign) id<GameResultDelegate> delegate;

-(void) replayPressed;

-(void) nextLevelPressed;

-(void) chooseLevelPressed;

@end

@protocol GameResultDelegate <NSObject>

@optional
-(void) replayGame;

-(void) nextLevel;

-(void) choseLevel;

@end