//
//  SubjectMenuView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubjectMenuView.h"

@implementation SubjectMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    sbjButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sbjButton.frame = CGRectMake(30, self.frame.size.height - 100, 100, 50);
    [sbjButton addTarget:self action:@selector(subjectChanged) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sbjButton];
    //读取配置文件中的当前主题
    FileUtils *util = [FileUtils sharedFileUtils];
    skin = [[util getUserDefaultsForKey:Skin] retain];
    if ([@"0" isEqualToString:skin]) {//当前为标准，显示小娇羞
        [sbjButton setTitle:@"小娇羞" forState:UIControlStateNormal];
    } else {//小娇羞
        [sbjButton setTitle:@"标准" forState:UIControlStateNormal];
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    [tapGesture release];
}

-(void) cancel {
    self.hidden = YES;
}

-(void) setHidden:(BOOL)hidden {
    if ([@"0" isEqualToString:skin]) {//当前为标准，显示小娇羞
        [sbjButton setTitle:@"小娇羞" forState:UIControlStateNormal];
    } else {//小娇羞
        [sbjButton setTitle:@"标准" forState:UIControlStateNormal];
    }
    super.hidden = hidden;
}

-(void) subjectChanged {
    [self cancel];
    FileUtils *util = [FileUtils sharedFileUtils];
    if ([@"0" isEqualToString:skin]) {
        [util setUserDefaults:@"1" key:Skin];
        skin = @"1";
    } else {
        [util setUserDefaults:@"0" key:Skin];
        skin = @"0";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:SubjectNotification object:skin];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([[touch view] isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

-(void) dealloc {
    [skin release];
    [super dealloc];
}

@end
