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
#import "WORD.h"
#import "ReaderView.h"
#import "Playbar.h"

@interface ReadViewController ()

//计时器调用
-(void) reciprocalTimer:(NSTimer*)timer;

-(void) plaBarTimerStop;

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
    
    //查询重点词汇
    ChapterService *service = [[[ChapterService alloc] init] autorelease];
    wordsArray = [[service queryWordsWithChapter:self.chapter] retain];
    
    //设置视图
    ReaderView *readView = [[ReaderView alloc] initWithFrame:self.view.frame];
    readView.controller = self;
    self.view = readView;
    [readView release];
}

-(void) showFavorite {
    
}

-(void) back {
    [((ReaderView*)self.view).playBar stop];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) pauseOrPlay:(id)sender {
    [self plaBarTimerStop];
    UIButton *playBtn = (UIButton*)sender;
    if (!playBtn.selected) {//播放
        [((ReaderView*)self.view).playBar play];
        [UIView animateWithDuration:.5f animations:^(void) {
            ((ReaderView*)self.view).playBar.alpha = 1;
        }];
        [self plaBarTimerStart];
    } else {
        [((ReaderView*)self.view).playBar pause];
    }
    playBtn.selected = !playBtn.selected;
}

-(void) reciprocalTimer:(NSTimer*)timer {
    if (timer == playBarTimer) {
        playLBarLeftTime++;
        if (playLBarLeftTime > 5) {
            [self plaBarTimerStop];
            [UIView animateWithDuration:1.0f animations:^(void) {
                ((ReaderView*)self.view).playBar.alpha = 0;
            }];
        }
    }
}

-(void) plaBarTimerStart {
    [self plaBarTimerStop];
    playLBarLeftTime = 0;
    playBarTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(reciprocalTimer:) userInfo:nil repeats:YES];
}

-(void) plaBarTimerStop {
    if (playBarTimer) {
        [playBarTimer invalidate];
        playBarTimer = nil;
    }
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

#pragma mark - tap handller

//处理单击事件
-(void) handleTapGesture:(UIGestureRecognizer*)gesture {
    DBLog(@"%@",@"单击事件触发");
    if (((ReaderView*)self.view).playBar.hasBegan &&((ReaderView*)self.view).playBar.alpha == 0) {
        [UIView animateWithDuration:.5f animations:^(void){
            ((ReaderView*)self.view).playBar.alpha = 1;
        } completion:^(BOOL finished) {
            [self plaBarTimerStart];
        }];
    }
}

//处理双击事件
-(void) handleDoubleTapGesture:(UIGestureRecognizer *)gesture {
    DBLog(@"%@",@"双击事件触发");
}

@end
