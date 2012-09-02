//
//  GameLevelView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLevelView.h"
#import "GAME.h"

@implementation GameLevelView

@synthesize controller;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame controller:(GameLevelViewController*)_gameController {
    self = [self initWithFrame:frame];
    if (self) {
        controller = _gameController;
        //添加第一关按钮
        UIButton *firstLevelBtn = [self createLevelButtonWithTitle:@"第一关" level:1];
        firstLevelBtn.frame = CGRectMake(60, frame.size.height - 80, 70, 30);
        firstLevelBtn.tag = 1;
        [firstLevelBtn addTarget:self action:@selector(beginGame:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:firstLevelBtn];
        //添加第二关按钮
        UIButton *secondLevelBtn = [self createLevelButtonWithTitle:@"第二关" level:2];
        secondLevelBtn.frame = CGRectMake(60+70+75, frame.size.height - 80, 70, 30);
        secondLevelBtn.tag = 2;
        [secondLevelBtn addTarget:self action:@selector(beginGame:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:secondLevelBtn];
        //添加第三关按钮
        UIButton *thirdLevelBtn = [self createLevelButtonWithTitle:@"第三关" level:3];
        thirdLevelBtn.frame = CGRectMake(60+70+75+75+60, frame.size.height - 80, 70, 30);
        thirdLevelBtn.tag = 3;
        [thirdLevelBtn addTarget:self action:@selector(beginGame:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:thirdLevelBtn];
        //添加返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(20, 10, 50, 30);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
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

-(UIButton*)createLevelButtonWithTitle:(NSString*) title level:(int)level {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    GAME *game = [controller gameLevelRecord:level];
    if (!game) {//为开始本关
        if (level == 1) {//第一关默认打开
            //[button setBackgroundImage:@"本关开启图片" forState:UIControlStateNormal];
        } else{//无记录，判断上一关是否通过，通过时，本关打开
            if ([controller gameLevelRecord:(level-1)]) {//上一关一通过，打开本关
                //[button setBackgroundImage:@"本关开启图片" forState:UIControlStateNormal];
            } else {
                //[button setBackgroundImage:@"本关关闭图片" forState:UIControlStateNormal];
                button.enabled = NO;
            }
        }
    } else {//存在成绩记录
        if ([game.level intValue] == 1) {//一颗星
            //[button setBackgroundImage:@"一颗星图片" forState:UIControlStateNormal];
        } else if ([game.level intValue] == 2) {//两颗星
            //[button setBackgroundImage:@"二颗星图片" forState:UIControlStateNormal];
        } else if ([game.level intValue] == 3) {//三颗星
            //[button setBackgroundImage:@"三颗星图片" forState:UIControlStateNormal];
        }
    }
    return button;
}

-(void) beginGame:(id)sender {
    [controller gameStartLevel:((UIButton*)sender).tag];
}

-(void) goBack {
    [controller goBack];
}

-(void) reCreateButton {
    UIButton *firstLevelBtn = (UIButton*)[self viewWithTag:1];
    [firstLevelBtn removeFromSuperview];
    firstLevelBtn = [self createLevelButtonWithTitle:@"第一关" level:1];
    firstLevelBtn.frame = CGRectMake(60, self.frame.size.height - 80, 70, 30);
    firstLevelBtn.tag = 1;
    [firstLevelBtn addTarget:self action:@selector(beginGame:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:firstLevelBtn];
    
    UIButton *secondLevelBtn = (UIButton*)[self viewWithTag:2];
    [secondLevelBtn removeFromSuperview];
    secondLevelBtn = [self createLevelButtonWithTitle:@"第二关" level:2];
    secondLevelBtn.frame = CGRectMake(60+70+75, self.frame.size.height - 80, 70, 30);
    secondLevelBtn.tag = 2;
    [secondLevelBtn addTarget:self action:@selector(beginGame:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:secondLevelBtn];
    //添加第三关按钮
    UIButton *thirdLevelBtn = (UIButton*)[self viewWithTag:3];
    [thirdLevelBtn removeFromSuperview];
    thirdLevelBtn = [self createLevelButtonWithTitle:@"第三关" level:3];
    thirdLevelBtn.frame = CGRectMake(60+70+75+75+60, self.frame.size.height - 80, 70, 30);
    thirdLevelBtn.tag = 3;
    [thirdLevelBtn addTarget:self action:@selector(beginGame:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:thirdLevelBtn];
}

@end
