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
#import "FTAnimation.h"

@implementation ReaderView

@synthesize controller,playBar,toolBar,scrollView,translationView;

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
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height+kToolBarHeight)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollEnabled = YES;
    [self addSubview:scrollView];
    [scrollView release];
    
    //添加文章标题
    CGSize titleSize = [controller.chapter.titleEn sizeWithFont:[UIFont boldSystemFontOfSize:20.0f] constrainedToSize:CGSizeMake(self.frame.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
    scrollView.contentSize = CGSizeMake(self.frame.size.width, contentSize.height+titleSize.height+130);
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, titleSize.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.numberOfLines = 3;
    titleLabel.text = controller.chapter.titleEn;
    [scrollView addSubview:titleLabel];
    [titleLabel release];
    
    //解析重点词汇
    contentLabel = [[IFTweetLabel alloc] initWithFrame:CGRectMake(5, titleSize.height+10, scrollView.frame.size.width-10, scrollView.contentSize.height-130)];
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
    [self performSelector:@selector(setPlayBar) withObject:nil afterDelay:.5f];
    [playBar release];
    
    //添加toolbar
    toolBar = [[ToolsBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height - kToolBarHeight, self.frame.size.width, kToolBarHeight)];
    toolBar.delegate = self;
    [self addSubview:toolBar];
    [toolBar release];
}

-(void) setPlayBar {
    [playBar setAudioFile:controller.chapter.chapterAudioUrl];
}

-(void) hideToolBar {
    [UIView animateWithDuration:.2f animations:^(void) {
        CGRect rect = toolBar.frame;
        rect.origin.y = rect.origin.y + rect.size.height*2;
        toolBar.frame = rect;
    }];
}

-(void) showToolBar {
    [UIView animateWithDuration:.2f animations:^(void) {
        CGRect rect = toolBar.frame;
        rect.origin.y = rect.origin.y - rect.size.height*2;
        toolBar.frame = rect;
    }];
}

-(void) dealloc {
    DBLog(@"%@",NSStringFromSelector(_cmd));
    [translationView release];
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

#pragma mark - toolbar delegate
-(void) subjectTouchEvent {
    
}

-(void) chapterTypeTouchEvent:(int) eventType {
    
}

-(void) sentenceTouchEvent {
    [controller showSentenceView];
}

-(void) gameTouchEvent {
    
}

#pragma mark - translation

-(void) showTranslationView {
    if (translationView) {
        [self addSubview:translationView];
        [translationView release];
        [translationView popIn:.4f delegate:nil];
    }
}

-(void) hideTranslationView {
    if (translationView) {
        [translationView popOut:.4f delegate:self];
    }
}

-(void) removeTranslationView {
    if (translationView) {
        [translationView removeFromSuperview];
        translationView = nil;
    }
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeTranslationView];
}

@end
