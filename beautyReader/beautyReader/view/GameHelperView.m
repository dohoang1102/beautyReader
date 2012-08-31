//
//  GameHelperView.m
//  beautyReader
//
//  Created by superjoo on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameHelperView.h"
#import "GameHelpViewController.h"

@implementation GameHelperView

@synthesize controller;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(20, 10, 65, 30);
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        textView = [[UITextView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y + 40, frame.size.width, frame.size.height-40)];
        [self addSubview:textView];
        textView.font = [UIFont systemFontOfSize:17.0f];
        textView.text = @"操作指南：\n连续点击两张卡片，若能够配对，卡片就消失。\n\n游戏介绍:\n每张卡片背后隐藏有一个英语单词或者时一个单词的汉语意思，你需要左的就是记住每个单词和它对应的词义的位置，快来将这些小鬼头们一网打尽吧！\n\n得分规则:\n在越短的事件内把卡片都配对成功，你所得到的星星就越多哦";
        textView.editable = NO;
        textView.exclusiveTouch = NO;
        [textView release];
    }
    return self;
}

-(void) goBack {
    [controller goBack];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
