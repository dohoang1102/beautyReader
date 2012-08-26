//
//  SecondLevelMenuView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondLevelMenuView.h"
#import "SecondLevelMenuController.h"

@implementation SecondLevelMenuView

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

-(id) initWithFrame:(CGRect)frame delegate:(id)delegate {
    self = [self initWithFrame:frame];
    self.controller = delegate;
    self.dataSource = controller;
    self.delegate = controller;
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

@end
