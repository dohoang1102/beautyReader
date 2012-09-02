//
//  CardView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CardView.h"

NSString *FlipNotification = @"FlipNotification";

@interface CardView()

-(void) animationDidStop;

@end

@implementation CardView

@synthesize isOn,identifier,title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame title:(NSString*)_title {
    self = [self initWithFrame:frame];
    if (self) {
        cardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cardButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [cardButton setBackgroundColor:[UIColor colorWithRed:244/255.0 green:148/255.0 blue:146/255.0 alpha:1.0]];
        [cardButton setTitle:_title forState:UIControlStateNormal];
        self.title = _title;
        [cardButton addTarget:self action:@selector(cardFlip:) forControlEvents:UIControlEventTouchUpInside];
        cardButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [cardButton.titleLabel sizeToFit];
        [self addSubview:cardButton];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


-(void) cardFlip:(id) sender {
    [UIView beginAnimations:nil context:nil]; 
    [UIView setAnimationTransition: 
     UIViewAnimationTransitionFlipFromLeft
                           forView:self cache:YES];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; 
    [UIView setAnimationDuration:.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    [UIView commitAnimations]; 
    if (isOn) {
        [cardButton setBackgroundImage:[UIImage imageNamed:@"pockerBg.png"] forState:UIControlStateNormal];
        [cardButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        [cardButton setBackgroundImage:nil forState:UIControlStateNormal];
        [cardButton setBackgroundColor:[UIColor colorWithRed:244/255.0 green:148/255.0 blue:146/255.0 alpha:1.0]];
        [cardButton setTitle:self.title forState:UIControlStateNormal];
    }
    isOn = !isOn;
}

-(void) animationDidStop {
    [[NSNotificationCenter defaultCenter] postNotificationName:FlipNotification object:self];
}

-(void) dealloc {
    [title release];
    [super dealloc];
}

@end
