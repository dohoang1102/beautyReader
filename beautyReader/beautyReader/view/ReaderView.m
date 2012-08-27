//
//  ReaderView.m
//  beautyReader
//
//  Created by superjoo on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReaderView.h"
#import "IFTweetLabel.h"
#import "ReadViewController.h"
#import "CHAPTER.h"

@implementation ReaderView

@synthesize controller,playBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //计算文本高度
    NSString *content = [[NSString alloc] initWithData:controller.chapter.chapterEn encoding:NSUTF8StringEncoding];
    CGSize contentSize = [content sizeWithFont:kCotentFont constrainedToSize:CGSizeMake(self.frame.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
    content = [content stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    
    //添加scrollview
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.frame.size.width, contentSize.height+80);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollEnabled = YES;
    [self addSubview:scrollView];
    [scrollView release];
    
    //解析重点词汇
    contentLabel = [[IFTweetLabel alloc] initWithFrame:CGRectMake(5, 0, scrollView.frame.size.width-10, scrollView.contentSize.height-60)];
    contentLabel.text = content;
    [contentLabel setNumberOfLines:0];
    [contentLabel setExpressions:[controller seperatorWords]];
    [contentLabel setFont:kCotentFont];
    [contentLabel setLinksEnabled:YES];
    [scrollView addSubview:contentLabel];
    [contentLabel release];
    
    //添加单击事件
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:controller action:@selector(handleTapGesture:)];
    singleTap.delegate = self;
    [self addGestureRecognizer:singleTap];
    [singleTap release];
    
    //添加双击事件
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:controller action:@selector(handleDoubleTapGesture:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [self addGestureRecognizer:doubleTap];
    [doubleTap release];
    
    //双击时屏蔽单击事件触发
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    //添加playbar
    playBar = [[PlayBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    [self addSubview:playBar];
    playBar.alpha = 0;
    playBar.delegate = self;
    [self performSelector:@selector(setPlayBar) withObject:nil afterDelay:0.1f];
    [playBar release];
}

-(void) setPlayBar {
    [playBar setAudioFile:controller.chapter.chapterAudioUrl];
}

-(void) dealloc {
    DBLog(@"%@",NSStringFromSelector(_cmd));
    [super dealloc];
}

#pragma mark - gesture delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([[touch view] isKindOfClass:[UIButton class]] || [[touch view] isKindOfClass:[UISlider class]]) {
        return NO;
    }
    return YES;
}

#pragma mark - playbar delegate

-(void) playBarChanged:(float) playBarValue {
    [controller plaBarTimerStart];
}

@end
