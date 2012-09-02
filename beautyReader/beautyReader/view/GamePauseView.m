//
//  GamePauseView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GamePauseView.h"

@implementation GamePauseView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.7;
        self.backgroundColor = [UIColor blackColor];
        UIImageView *altImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
        altImgView.center = self.center;
        altImgView.userInteractionEnabled = YES;
        //继续游戏
        UIButton *continueBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        continueBtn.frame = CGRectMake(10, 40, 80, 35);
        [continueBtn addTarget:self action:@selector(resume) forControlEvents:UIControlEventTouchUpInside];
        [continueBtn setTitle:@"继续游戏" forState:UIControlStateNormal];
        [altImgView addSubview:continueBtn];
        //返回主菜单
        UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        mainBtn.frame = CGRectMake(110, 40, 80, 35);
        [mainBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
        [mainBtn setTitle:@"返回主界面" forState:UIControlStateNormal];
        [altImgView addSubview:mainBtn];
        [self addSubview:altImgView];
        [altImgView release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) resume {
    if (delegate && [delegate respondsToSelector:@selector(resumeGame)]) {
        [delegate resumeGame];
    }
}

-(void) backHome {
    if (delegate && [delegate respondsToSelector:@selector(backToMenu)]) {
        [delegate backToMenu];
    }
}

@end
