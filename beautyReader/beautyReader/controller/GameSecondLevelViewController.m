//
//  GameSecondLevelViewController.m
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSecondLevelViewController.h"
#import "GameMenuViewController.h"
#import "CHAPTER.h"
#import "GameSecondLevelView.h"
#import "FXLabel.h"
#import "ChapterService.h"
#import "GameLevelViewController.h"
#import "GameThirdLevelViewController.h"
#import "CardView.h"

@interface GameSecondLevelViewController ()

@end

@implementation GameSecondLevelViewController

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
    
    GameSecondLevelView *secondLevel = [[GameSecondLevelView alloc] initWithFrame:self.view.frame];
    self.view = secondLevel;
    secondLevel.controller = self;
    [secondLevel release];
    //注册游戏准备完毕通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startTimer) name:SeGameReadyNotification object:nil];
    totalTime = 35;//游戏总时长为35秒，前5秒种为记忆时间，后30秒为游戏进度时间
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SeGameReadyNotification object:nil];
    [chapter release];
    [super dealloc];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

//游戏开始
-(void) startTimer {
    if (!gameTimer) {
        GameSecondLevelView *secondLevelView = (GameSecondLevelView*)self.view;
        secondLevelView.totalTimeLabel.hidden = NO;
        secondLevelView.totalTimeLabel.text = @"倒计时:35s";
        gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateGameTime) userInfo:nil repeats:YES];
        timerStarted = YES;
    }
}

-(void) updateGameTime {
    totalTime --;
    GameSecondLevelView *secondLevelView = (GameSecondLevelView*)self.view;
    [secondLevelView updateTimerLabel];
    if (totalTime == 30) {//翻牌
        [secondLevelView takeOverAllCards];
    }
    if (totalTime < 0) {
        secondLevelView.totalTimeLabel.text = @"倒计时:0s";
    }
}

//游戏结束，显示游戏结果
-(void) showGameResult {
    if (gameTimer) {
        [gameTimer invalidate];
        gameTimer = nil;
    }
    GameSecondLevelView *secondLevelView = (GameSecondLevelView*)self.view;
    secondLevelView.totalTimeLabel.hidden = YES;
    resultView = [[GameResultView alloc] initWithFrame:secondLevelView.frame];
    resultView.delegate = self;
    resultView.hasNextLevel = YES;
    if (30 - totalTime > 0 && 30-totalTime <= 10 ) {//三分
        resultView.resultLevel = 3;
    } else if (30 - totalTime > 10 && 30 - totalTime <=20 ) {//二分
        resultView.resultLevel = 2;
    } else if (30 - totalTime > 20 && 30 - totalTime < 30) {//一分
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
        BOOL updateResult = [service updateGameScore:chapter.chapterId level:2 time:(30-totalTime) score:resultView.resultLevel];
        if (updateResult) {
            DBLog(@"%@",@"==================更新数据库成功");
        } else {
            DBLog(@"%@",@"==================更新数据库失败");
        }
    }
}

//游戏暂停
-(void) pauseGame {
    GameSecondLevelView *secondLevelView = (GameSecondLevelView*)self.view;
    [secondLevelView pauseTimer];
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
    GameSecondLevelView *secondLevelView = (GameSecondLevelView*)self.view;
    [secondLevelView resumeTimer];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SeGameReadyNotification object:nil];
    [self viewDidLoad];
}

//下一关
-(void) nextLevel {
    GameThirdLevelViewController *thirdLevel = [[GameThirdLevelViewController alloc] init];
    thirdLevel.chapter = self.chapter;
    [self.navigationController pushViewController:thirdLevel animated:YES];
    [thirdLevel release];
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
