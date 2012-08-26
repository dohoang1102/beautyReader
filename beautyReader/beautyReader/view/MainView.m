//
//  MainView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainView.h"
#import "MainViewController.h"

@interface MainView()

-(void) bookButtonPressed:(id)sender;

@end

@implementation MainView

@synthesize controller;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIButton *springBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    springBtn.frame = CGRectMake(30, 20, 100, 150);
    springBtn.tag = 100;
    [springBtn setTitle:@"春眠不觉晓" forState:UIControlStateNormal];
    springBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    springBtn.backgroundColor = [UIColor grayColor];
    [springBtn addTarget:self action:@selector(bookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:springBtn];
    
    UIButton *summerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    summerBtn.frame = CGRectMake(190, 20, 100, 150);
    summerBtn.tag = 101;
    [summerBtn setTitle:@"夏夜识花香" forState:UIControlStateNormal];
    summerBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    summerBtn.backgroundColor = [UIColor grayColor];
    [summerBtn addTarget:self action:@selector(bookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:summerBtn];
    
    UIButton *autumnBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    autumnBtn.frame = CGRectMake(30, 220, 100, 150);
    autumnBtn.tag = 102;
    [autumnBtn setTitle:@"秋风觉人醒" forState:UIControlStateNormal];
    autumnBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    autumnBtn.backgroundColor = [UIColor grayColor];
    [autumnBtn addTarget:self action:@selector(bookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:autumnBtn];
    
    UIButton *winterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    winterBtn.frame = CGRectMake(190, 220, 100, 150);
    winterBtn.tag = 103;
    [winterBtn setTitle:@"冬日独思量" forState:UIControlStateNormal];
    winterBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    winterBtn.backgroundColor = [UIColor grayColor];
    [winterBtn addTarget:self action:@selector(bookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:winterBtn];
}

-(void) bookButtonPressed:(id)sender {
    UIButton *button = (UIButton*)sender;
    int subjectType = 1;
    switch (button.tag) {
        case 100:
            subjectType = 1;
            break;
        case 101:
            subjectType = 2;
            break;
        case 102:
            subjectType = 3;
            break;
        case 103:
            subjectType = 4;
            break;
        default:
            break;
    }
    [controller showFiestLevelMenu:subjectType];
}

@end
