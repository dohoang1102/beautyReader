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
#import "FavoritesViewController.h"
#import "SentenceViewController.h"
#import "GameMenuViewController.h"

@interface ReadViewController ()

//计时器调用
-(void) reciprocalTimer:(NSTimer*)timer;

-(void) plaBarTimerStop;

-(void) fullScreen;

-(void) wordExplainTimerStart;

-(void) wordExplainTimerStop;

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
    navBarTintColor = [self.navigationController.navigationBar.tintColor copy];
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
    
    //注册气泡事件通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLongTapGesture:) name:IFTweetLabelLongTapNotification object:nil];
    
    //注册主题更换事件通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSkin:) name:SubjectNotification object:nil];
}

-(void) setSkin {
    FileUtils *fileUtil = [FileUtils sharedFileUtils];
    NSString *skin = [fileUtil getUserDefaultsForKey:Skin];
    if (skin == nil || (![skin isEqualToString:@"0"] && ![skin isEqualToString:@"1"])) {
        skin = @"0";
    }
    if ([skin isEqualToString:@"0"]) {//标准主题
        self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    } else {//小娇羞主题
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    }
}

-(void) showFavorite {
    FavoritesViewController *favoritesController = [[FavoritesViewController alloc] init];
    [self.navigationController pushViewController:favoritesController animated:YES];
    [favoritesController release];
}

-(void) beginGame {
    GameMenuViewController *gameController = [[GameMenuViewController alloc] init];
    gameController.chapter = self.chapter;
    [self.navigationController pushViewController:gameController animated:YES];
    [gameController release];
}

-(void) hideExplainView {
    ReaderView *readView = (ReaderView*)self.view;
    [readView hideTranslationView];
}

-(void) back {
    [((ReaderView*)self.view).playBar stop];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) pauseOrPlay:(id)sender {
    [self plaBarTimerStart];
    UIButton *playBtn = (UIButton*)sender;
    if (!playBtn.selected) {//播放
        [((ReaderView*)self.view).playBar play];
        [UIView animateWithDuration:.5f animations:^(void) {
            ((ReaderView*)self.view).playBar.alpha = 1;
        }];
        [playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    } else {
        [((ReaderView*)self.view).playBar pause];
        [playBtn setTitle:@"播放" forState:UIControlStateNormal];
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
    } else if (timer == wordExplainTimer) {
        wordExplainLeftTime++;
        if (wordExplainLeftTime > 5) {
            [self wordExplainTimerStop];
            [self hideExplainView];
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

-(void) wordExplainTimerStart {
    [self wordExplainTimerStop];
    wordExplainLeftTime = 0;
    wordExplainTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(reciprocalTimer:) userInfo:nil repeats:YES];
}

-(void) wordExplainTimerStop {
    if (wordExplainTimer) {
        [wordExplainTimer invalidate];
        wordExplainTimer = nil;
    }
}

-(void) fullScreen {
    if (!isFullScreen) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [(ReaderView*)self.view hideToolBar];
        CGSize contentSize = ((ReaderView*)self.view).scrollView.contentSize;
        contentSize.height = contentSize.height - 80;
        ((ReaderView*)self.view).scrollView.contentSize = contentSize;
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [(ReaderView*)self.view showToolBar];
        CGSize contentSize = ((ReaderView*)self.view).scrollView.contentSize;
        contentSize.height = contentSize.height + 80;
        ((ReaderView*)self.view).scrollView.contentSize = contentSize;
    }
    isFullScreen = !isFullScreen;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) viewWillAppear:(BOOL)animated {
    //设置皮肤包
    [self setSkin];
    self.navigationController.navigationBarHidden = NO;
}

-(void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.tintColor = navBarTintColor;
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IFTweetLabelLongTapNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SubjectNotification object:nil];
    [chapter release];
    [wordsArray release];
    [navBarTintColor release];
    [super dealloc];
}

-(void) changeSkin:(NSNotification*)notification {
    DBLog(@"%@",@"更换皮肤。。。");
    [self viewWillAppear:YES];
}

#pragma mark - tap handller

//处理单击事件
-(void) handleTapGesture:(UIGestureRecognizer*)gesture {
    DBLog(@"%@",@"单击事件触发");
    /*
    if (((ReaderView*)self.view).playBar.hasBegan &&((ReaderView*)self.view).playBar.alpha == 0) {
        [UIView animateWithDuration:.5f animations:^(void){
            ((ReaderView*)self.view).playBar.alpha = 1;
        } completion:^(BOOL finished) {
            [self plaBarTimerStart];
        }];
    }
     */
    ReaderView *readView = (ReaderView*)self.view;
    if (readView.translationView) {
        [self wordExplainTimerStop];
        [readView hideTranslationView];
    }
    [self fullScreen];
}

//处理双击事件
-(void) handleDoubleTapGesture:(UIGestureRecognizer *)gesture {
    DBLog(@"%@",@"双击事件触发");
}

//处理长按事件
-(void) handleLongTapGesture:(NSNotification*)notificcation {
    //视图移入部分
    CGPoint textScrollPoint = [((ReaderView*)self.view).scrollView contentOffset];
    //获取点击到的单词
    NSString *tapWord = [notificcation.object objectAtIndex:0];
    ReaderView *readView = (ReaderView*)self.view;
    [readView removeTranslationView];
    readView.translationView = [[[WordTranslateView alloc] initWithFrame:CGRectZero] autorelease];
    for (WORD *word in wordsArray) {
        NSArray *wordConArr = [word.content componentsSeparatedByString:@"|"];
        if (wordConArr && [wordConArr count] > 0) {
            if ([tapWord isEqualToString:[wordConArr objectAtIndex:0]]) {
                readView.translationView.word = word;
                break;
            }
        }
    }
    //获取单击点的坐标
    CGPoint tapPoint = [(NSValue*)[notificcation.object objectAtIndex:1] CGPointValue];
    CGFloat xOffset = tapPoint.x - textScrollPoint.x;
    CGFloat yOffset = tapPoint.y - textScrollPoint.y;
    ViewDirector direct = LEFT_UP;
    CGRect transFrame = CGRectZero;
    if(xOffset <= readView.translationView.frame.size.width && yOffset <= readView.translationView.frame.size.height) {//右下
        direct = RIGHT_DOWN;
        transFrame = CGRectMake(xOffset, yOffset+readView.translationView.frame.size.height/2+20, readView.translationView.frame.size.width, readView.translationView.frame.size.height);
        NSLog(@"...右下");
    } else if (xOffset <= readView.translationView.frame.size.width && yOffset > readView.translationView.frame.size.height) {//右上
        direct = RIGHT_UP;
        transFrame = CGRectMake(xOffset, yOffset-readView.translationView.frame.size.height/2-5, readView.translationView.frame.size.width, readView.translationView.frame.size.height);
        NSLog(@"右上");
    } else if (xOffset > readView.translationView.frame.size.width && yOffset <= readView.translationView.frame.size.height) {//左下
        direct = LEFT_DOWN;
        transFrame = CGRectMake(xOffset-readView.translationView.frame.size.width-5, yOffset+readView.translationView.frame.size.height/2+20, readView.translationView.frame.size.width, readView.translationView.frame.size.height);
        NSLog(@"坐下");
    } else if (xOffset > readView.translationView.frame.size.width && yOffset > readView.translationView.frame.size.height) {//左上
        direct = LEFT_UP;
        transFrame = CGRectMake(xOffset-readView.translationView.frame.size.width-5, yOffset-readView.translationView.frame.size.height/2-10, readView.translationView.frame.size.width, readView.translationView.frame.size.height);
        NSLog(@"坐上");
    }
    readView.translationView.frame = transFrame;
    readView.translationView.director = direct;
    [readView showTranslationView];
    [self wordExplainTimerStart];
}

#pragma mark - deal tool bar function
-(void) showSentenceView {
    SentenceViewController *sentenceCtroller = [[SentenceViewController alloc] init];
    sentenceCtroller.chapter = self.chapter;
    [self.navigationController pushViewController:sentenceCtroller animated:YES];
    [sentenceCtroller release];
}

@end
