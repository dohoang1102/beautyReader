//
//  GameLevelViewController.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameLevelViewController.h"
#import "CHAPTER.h"
#import "GameLevelView.h"
#import "GAME.h"
#import "ChapterService.h"
#import "GameFirstLevelViewController.h"
#import "GameSecondLevelViewController.h"
#import "GameThirdLevelViewController.h"

@interface GameLevelViewController ()

@end

@implementation GameLevelViewController

@synthesize chapter;

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
	CGRect bounds = [UIApplication sharedApplication].keyWindow.frame;
    self.view.frame = bounds;
    
    GameLevelView *gameLevel = [[GameLevelView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width) controller:self];
    self.view = gameLevel;
    [gameLevel release];
}

-(GAME*) gameLevelRecord:(int)level {
    if (!chapter.games || [chapter.games count] == 0) {
        return nil;
    }
    for (GAME *game in chapter.games) {
        if ([game.level intValue] == level) {
            return game;
        }
    }
    return nil;
}

-(void) gameStartLevel:(int)level {
    switch (level) {
        case 1: {
            GameFirstLevelViewController *firstLevel = [[GameFirstLevelViewController alloc] init];
            firstLevel.chapter = self.chapter;
            [self.navigationController pushViewController:firstLevel animated:YES];
            [firstLevel release];
            break;
        }
        case 2: {
            GameSecondLevelViewController *secondLevel = [[GameSecondLevelViewController alloc] init];
            secondLevel.chapter = self.chapter;
            [self.navigationController pushViewController:secondLevel animated:YES];
            [secondLevel release];
            break;
        }
        case 3: {
            GameThirdLevelViewController *thirdLevel = [[GameThirdLevelViewController alloc] init];
            thirdLevel.chapter = self.chapter;
            [self.navigationController pushViewController:thirdLevel animated:YES];
            [thirdLevel release];
            break;
        }
        default:
            break;
    }
}

-(void) goBack {
    [self.navigationController popViewControllerAnimated:YES];
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

-(void) viewWillAppear:(BOOL)animated {//查询最新保存的游戏数据
    ChapterService *service = [[[ChapterService alloc] init] autorelease];
    self.chapter = [service queryChapterWithId:[chapter.chapterId intValue]];
    GameLevelView *view = (GameLevelView*)self.view;
    [view reCreateButton];
}

-(void) dealloc {
    [chapter release];
    [super dealloc];
}

@end
