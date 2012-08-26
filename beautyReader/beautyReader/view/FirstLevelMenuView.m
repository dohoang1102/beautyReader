//
//  FirstLevelMenuView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstLevelMenuView.h"
#import "FirstLevelMenuController.h"

@implementation FirstLevelMenuView

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

- (void)drawRect:(CGRect)rect {
//    self.dataSource = controller;
//    self.delegate = controller;
}

@end
