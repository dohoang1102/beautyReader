//
//  ReadViewController.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReadViewController.h"
#import "CHAPTER.h"
#import "ChapterService.h"
#import "IFTweetLabel.h"
#import "WORD.h"

@interface ReadViewController ()

@end

@implementation ReadViewController

@synthesize chapter,subjectType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [UIApplication sharedApplication].keyWindow.frame;
	self.title = chapter.chapterName;
    //导航左侧视图
    UIView *leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)] autorelease];
    leftView.backgroundColor = [UIColor clearColor];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, 5, 40, 34);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:backBtn];
    UIButton *playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    playOrPauseBtn.frame = CGRectMake(50, 5, 40, 34);
    [playOrPauseBtn setTitle:@"播放" forState:UIControlStateNormal];
    [playOrPauseBtn addTarget:self action:@selector(pauseOrPlay:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:playOrPauseBtn];
    UIBarButtonItem *leftItem = [[[UIBarButtonItem alloc] initWithCustomView:leftView] autorelease];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //收藏夹
    UIBarButtonItem *rightItem = [[[UIBarButtonItem alloc] initWithTitle:@"收藏夹" style:UIBarButtonItemStylePlain target:self action:@selector(showFavorite)] autorelease];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //计算文本高度
    NSString *content = [[NSString alloc] initWithData:chapter.chapterEn encoding:NSUTF8StringEncoding];
    CGSize contentSize = [content sizeWithFont:kCotentFont constrainedToSize:CGSizeMake(self.view.frame.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
    content = [content stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
    
    //添加scrollview
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, contentSize.height+80);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    [scrollView release];
    
    //查询重点词汇
    ChapterService *service = [[[ChapterService alloc] init] autorelease];
    wordsArray = [[service queryWordsWithChapter:self.chapter] retain];
    //解析重点词汇
    contentLabel = [[IFTweetLabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, contentSize.height)];
    contentLabel.text = content;
    [contentLabel setNumberOfLines:0];
    [contentLabel setExpressions:[self seperatorWords]];
    [contentLabel setFont:kCotentFont];
    [contentLabel setLinksEnabled:YES];
    [scrollView addSubview:contentLabel];
    [contentLabel release];
}

-(void) showFavorite {
    
}

-(void) back {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) pauseOrPlay:(id)sender {
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSArray*)seperatorWords {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    if (!wordsArray) {
        return array;
    }
    for (WORD *word in wordsArray) {
        NSArray *wordConArr = [word.content componentsSeparatedByString:@"|"];
        if (wordConArr && [wordConArr count] > 0) {
            [array addObject:[wordConArr objectAtIndex:0]];
        }
    }
    return array;
}

-(void) dealloc {
    [chapter release];
    [wordsArray release];
    [super dealloc];
}

@end
