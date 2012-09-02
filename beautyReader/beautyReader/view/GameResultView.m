//
//  GameResultView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameResultView.h"

@implementation GameResultView

@synthesize resultLevel,hasNextLevel,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = .8;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    levelInfoLevel = [[UILabel alloc] initWithFrame:CGRectMake(60, 80, 100, 30)];
    levelInfoLevel.backgroundColor = [UIColor clearColor];
    levelInfoLevel.text = @"本关得分：";
    [self addSubview:levelInfoLevel];
    [levelInfoLevel release];
    
    scoreImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(160, 180, 80, 30)];
    scoreImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:scoreImageView];
    [scoreImageView release];
    
    replayBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [replayBtn setTitle:@"重玩" forState:UIControlStateNormal];
    [replayBtn addTarget:self action:@selector(replayPressed) forControlEvents:UIControlEventTouchUpInside];
    replayBtn.frame = CGRectMake(60, rect.size.height - 90, 80, 40);
    [self addSubview:replayBtn];
    
    nextLevelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nextLevelBtn setTitle:@"下一关" forState:UIControlStateNormal];
    [nextLevelBtn addTarget:self action:@selector(nextLevelPressed) forControlEvents:UIControlEventTouchUpInside];
    nextLevelBtn.frame = CGRectMake(60+80+60, rect.size.height - 90, 80, 40);
    [self addSubview:nextLevelBtn];
    
    chooseLevelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [chooseLevelBtn setTitle:@"选择关卡" forState:UIControlStateNormal];
    [chooseLevelBtn addTarget:self action:@selector(chooseLevelPressed) forControlEvents:UIControlEventTouchUpInside];
    chooseLevelBtn.frame = CGRectMake(60+80+60+80+60, rect.size.height - 90, 80, 40);
    [self addSubview:chooseLevelBtn];
    
    if (resultLevel > 0) {//通过
        if (resultLevel == 1) {//第一等级
            
        } else if (resultLevel == 2) {//第二等级
            
        } else if (resultLevel == 3) {//第三等级
            
        }
        if (!hasNextLevel) {
            nextLevelBtn.hidden = YES;
        }
    } else {
        levelInfoLevel.text = @"游戏失败";
        nextLevelBtn.enabled = NO;
    }
}

-(void) replayPressed {
    if (delegate && [delegate respondsToSelector:@selector(replayGame)]) {
        [delegate replayGame];
    }
}

-(void) nextLevelPressed {
    if (delegate && [delegate respondsToSelector:@selector(nextLevel)]) {
        [delegate nextLevel];
    }
}

-(void) chooseLevelPressed {
    if (delegate && [delegate respondsToSelector:@selector(choseLevel)]) {
        [delegate choseLevel];
    }
}

@end
