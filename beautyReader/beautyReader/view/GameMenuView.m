//
//  GameMenuView.m
//  beautyReader
//
//  Created by superjoo on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameMenuView.h"
#import "GameMenuViewController.h"

@implementation GameMenuView

@synthesize controller;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1.0 green:218/255.0 blue:185/255.0 alpha:1.0];
        
        UIButton *helpBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        helpBtn.frame = CGRectMake(60, frame.size.height - 90, 80, 40);
        [helpBtn setTitle:@"规则" forState:UIControlStateNormal];
        [helpBtn addTarget:self action:@selector(regular) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:helpBtn];
        
        UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        beginBtn.frame = CGRectMake(60+80+60, frame.size.height - 90, 80, 40);
        [beginBtn setTitle:@"开始" forState:UIControlStateNormal];
        [beginBtn addTarget:self action:@selector(begin) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:beginBtn];
        
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        exitBtn.frame = CGRectMake(60+80+60+80+60, frame.size.height - 90, 80, 40);
        [exitBtn setTitle:@"退出" forState:UIControlStateNormal];
        [exitBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:exitBtn];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
}

-(void) regular {
    [controller showHelpInfo];
}

-(void) begin {
    [controller showGameLevel];
}

-(void) exit {
    [controller goBack];
}

@end
