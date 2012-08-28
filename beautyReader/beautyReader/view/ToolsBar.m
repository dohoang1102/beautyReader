//
//  ToolsBar.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolsBar.h"

@implementation ToolsBar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kToolBarHeight);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    float width = self.frame.size.width/4;
    
    UIButton *subjectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subjectBtn.frame = CGRectMake(0, 0, width, kToolBarHeight);
    [subjectBtn setTitle:@"主题" forState:UIControlStateNormal];
    [subjectBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    subjectBtn.backgroundColor = [UIColor brownColor];
    [subjectBtn addTarget:self action:@selector(subjectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:subjectBtn];
    
    UIButton *chapterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chapterBtn.frame = CGRectMake(width, 0, width, kToolBarHeight);
    [chapterBtn setTitle:@"英文" forState:UIControlStateNormal];
    [chapterBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    chapterBtn.backgroundColor = [UIColor grayColor];
    [chapterBtn addTarget:self action:@selector(chapterChangeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:chapterBtn];
    
    UIButton *sentenceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sentenceBtn.frame = CGRectMake(width*2, 0, width, kToolBarHeight);
    [sentenceBtn setTitle:@"妙语" forState:UIControlStateNormal];
    [sentenceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    sentenceBtn.backgroundColor = [UIColor colorWithRed:.4 green:.3 blue:.6 alpha:1.0];
    [sentenceBtn addTarget:self action:@selector(sentenceButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sentenceBtn];
    
    UIButton *gameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    gameBtn.frame = CGRectMake(width*3, 0, width, kToolBarHeight);
    [gameBtn setTitle:@"游戏" forState:UIControlStateNormal];
    [gameBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    gameBtn.backgroundColor = [UIColor brownColor];
    [gameBtn addTarget:self action:@selector(gameButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:gameBtn];
}

-(void) subjectButtonPressed:(id) sender {
    if (delegate && [delegate respondsToSelector:@selector(subjectTouchEvent)]) {
        [delegate subjectTouchEvent];
    }
}

-(void) chapterChangeButtonPressed:(id) sender {
    UIButton *chapterBtn = (UIButton*)sender;
    if (chapterContentType == 0) {
        chapterContentType = 1;
        [chapterBtn setTitle:@"英文" forState:UIControlStateNormal];
    } else if (chapterContentType == 1) {
        chapterContentType = 2;
        [chapterBtn setTitle:@"中/英" forState:UIControlStateNormal];
    } else if (chapterContentType == 2) {
        chapterContentType = 0;
        [chapterBtn setTitle:@"英文" forState:UIControlStateNormal];
    }
    if (delegate && [delegate respondsToSelector:@selector(chapterTypeTouchEvent:)]) {
        [delegate chapterTypeTouchEvent:chapterContentType];
    }
}

-(void) sentenceButtonPressed:(id) sender {
    if (delegate && [delegate respondsToSelector:@selector(sentenceTouchEvent)]) {
        [delegate sentenceTouchEvent];
    }
}

-(void) gameButtonPressed:(id) sender {
    if (delegate && [delegate respondsToSelector:@selector(gameTouchEvent)]) {
        [delegate gameTouchEvent];
    }
}

@end
