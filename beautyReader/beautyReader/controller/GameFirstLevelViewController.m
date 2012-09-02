//
//  GameFirstLevelViewController.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameFirstLevelViewController.h"
#import "GameMenuViewController.h"
#import "CHAPTER.h"
#import "GameFirstLevelView.h"
#import "FXLabel.h"
#import "ChapterService.h"
#import "GameLevelViewController.h"
#import "GameSecondLevelViewController.h"
#import "CardView.h"

@interface GameFirstLevelViewController ()

@end

@implementation GameFirstLevelViewController

@synthesize chapter,totalTime;

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
    self.view.frame = CGRectMake(0, 0, 480, 320);
    
    GameFirstLevelView *firstLevel = [[GameFirstLevelView alloc] initWithFrame:self.view.frame];
    self.view = firstLevel;
    firstLevel.controller = self;
    [firstLevel release];
    //注册游戏准备完毕通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startTimer) name:GameReadyNotification object:nil];
    totalTime = 17;//游戏总时长为17秒，前两秒种为记忆时间，后15秒为游戏进度时间
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

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GameReadyNotification object:nil];
    [chapter release];
    [super dealloc];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

//游戏开始
-(void) startTimer {
    if (!gameTimer) {
        GameFirstLevelView *firstLevelView = (GameFirstLevelView*)self.view;
        firstLevelView.totalTimeLabel.hidden = NO;
        firstLevelView.totalTimeLabel.text = @"倒计时:17s";
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateGameTime) userInfo:nil repeats:YES];
        timerStarted = YES;
    }
}

-(void) updateGameTime {
    totalTime --;
    GameFirstLevelView *firstLevelView = (GameFirstLevelView*)self.view;
    [firstLevelView updateTimerLabel];
    if (totalTime == 15) {//翻牌
        [firstLevelView takeOverAllCards];
    }
    if (totalTime < 0) {
        firstLevelView.totalTimeLabel.text = @"倒计时:0s";
    }
}

//游戏结束，显示游戏结果
-(void) showGameResult {
    if (gameTimer) {
        [gameTimer invalidate];
        gameTimer = nil;
    }
    GameFirstLevelView *firstLevelView = (GameFirstLevelView*)self.view;
    firstLevelView.totalTimeLabel.hidden = YES;
    resultView = [[GameResultView alloc] initWithFrame:firstLevelView.frame];
    resultView.delegate = self;
    resultView.hasNextLevel = YES;
    if (15 - totalTime > 0 && 15-totalTime <= 5 ) {//三分
        resultView.resultLevel = 3;
    } else if (15 - totalTime > 5 && 15 - totalTime <=10 ) {//二分
        resultView.resultLevel = 2;
    } else if (15 - totalTime > 10 && 15 - totalTime < 15) {//一分
        resultView.resultLevel = 1;
    } else {
        resultView.resultLevel = 0;
    }
    [self.view addSubview:resultView];
    [resultView release];
    resultView.alpha = 0;
    [UIView animateWithDuration:.2f animations:^(void) {
        resultView.alpha = .8;
    }];
    //更新数据库
    if (resultView.resultLevel > 0) {
        ChapterService *service = [[[ChapterService alloc] init] autorelease];
        BOOL updateResult = [service updateGameScore:chapter.chapterId level:1 time:(15-totalTime) score:resultView.resultLevel];
        if (updateResult) {
            DBLog(@"%@",@"==================更新数据库成功");
        } else {
            DBLog(@"%@",@"==================更新数据库失败");
        }
    }
}

//游戏暂停
-(void) pauseGame {
    GameFirstLevelView *firstLevelView = (GameFirstLevelView*)self.view;
    [firstLevelView pauseTimer];
    if (gameTimer) {
        [gameTimer invalidate];
        gameTimer = nil;
    }
    if (!pauseView) {
        pauseView = [[GamePauseView alloc] initWithFrame:self.view.frame];
        pauseView.delegate = self;
        [self.view addSubview:pauseView];
        [pauseView release];
        pauseView.alpha = 0;
        [UIView animateWithDuration:.3f animations:^(void) {
            pauseView.alpha = 0.8f;
        }];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self.view name:FlipNotification object:nil];
}

#pragma mark - game pause delegate
//继续游戏
-(void) resumeGame {
    GameFirstLevelView *firstLevelView = (GameFirstLevelView*)self.view;
    [firstLevelView resumeTimer];
    if (timerStarted) {
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateGameTime) userInfo:nil repeats:YES];
    }
    if (pauseView) {
        [pauseView removeFromSuperview];
        pauseView = nil;
    }
}

//返回主界面
-(void) backToMenu {
    NSArray *controllers = self.navigationController.viewControllers;
    for (UIViewController *controller  in controllers) {
        if ([controller isKindOfClass:[GameMenuViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

#pragma mark - game result delegate
//重新开始游戏
-(void) replayGame {
    if (resultView) {
        [resultView removeFromSuperview];
        resultView = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GameReadyNotification object:nil];
    [self viewDidLoad];
}

//下一关
-(void) nextLevel {
    GameSecondLevelViewController *secondLevel = [[GameSecondLevelViewController alloc] init];
    secondLevel.chapter = self.chapter;
    [self.navigationController pushViewController:secondLevel animated:YES];
    [secondLevel release];
}

//选择关数
-(void) choseLevel {
    NSArray *controllers = self.navigationController.viewControllers;
    for (UIViewController *controller  in controllers) {
        if ([controller isKindOfClass:[GameLevelViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

@end
