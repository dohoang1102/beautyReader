//
//  FavoritesView.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoritesView.h"
#import "MCSegmentedControl.h"
#import "WordListView.h"
#import "SentenceListView.h"
#import "FavoritesViewController.h"

@implementation FavoritesView

@synthesize controller;

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
    isFirstLoad = YES;
    NSArray *items = [NSArray arrayWithObjects:
					  @"生词",
					  @"妙语",
					  //[UIImage imageNamed:@"star.png"],
					  nil];
	MCSegmentedControl *segmentedControl = [[MCSegmentedControl alloc] initWithItems:items];
	segmentedControl.frame = CGRectMake(10.0f, 10.0f, 300.0f, 44.0f);
	[self addSubview:segmentedControl];
	[segmentedControl addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.tintColor = [UIColor colorWithRed:.0 green:.6 blue:.0 alpha:1.0];
	segmentedControl.selectedItemColor   = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;
	segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
	[segmentedControl release];
    
    //添加单词列表
    wordListView = [[WordListView alloc] initWithFrame:CGRectMake(0,  segmentedControl.frame.origin.y+segmentedControl.frame.size.height+5, self.frame.size.width, self.frame.size.height - segmentedControl.frame.origin.y-segmentedControl.frame.size.height-5) style:UITableViewStylePlain];
    [self addSubview:wordListView];
    wordListView.hidden = YES;
    //初始化HUD
    [self performSelector:@selector(loadHUD:) withObject:[NSNumber numberWithInt:1] afterDelay:.2f];
    isFirstLoad = NO;
}

-(void) loadHUD:(NSNumber*)loadType {
    if ([loadType intValue] == 1) {//查询单词列表
        if (wordList && [wordList count] > 0) {
            wordListView.hidden = NO;
            if (!wordListView.superview) {
                [self addSubview:wordListView];
            }
            wordListView.wordListArray = wordList;
            [wordListView reloadData];
            [sentenceView removeFromSuperview];
        } else {
            [HUD release];
            HUD = [[MBProgressHUD alloc] initWithView:controller.navigationController.view];
            [controller.navigationController.view addSubview:HUD];
            HUD.animationType = MBProgressHUDAnimationZoom;
            HUD.delegate = self;
            HUD.labelText = @"加载中";
            [HUD showWhileExecuting:@selector(loadWordList) onTarget:self withObject:nil animated:YES];
        }
    } else {//查询句子列表
        if (sentenceList && [sentenceList count] > 0) {
            sentenceView.hidden = NO;
            if (!sentenceView.superview) {
                [self addSubview:sentenceView];
            }
            sentenceView.sentenceListArray = sentenceList;
            [sentenceView reloadData];
            [wordListView removeFromSuperview];
        } else {
            [HUD release];
            HUD = [[MBProgressHUD alloc] initWithView:controller.navigationController.view];
            [controller.navigationController.view addSubview:HUD];
            HUD.animationType = MBProgressHUDAnimationZoom;
            HUD.delegate = self;
            HUD.labelText = @"加载中";
            [HUD showWhileExecuting:@selector(loadSentenceList) onTarget:self withObject:nil animated:YES];
        }
    }
}

-(void) loadWordList {
    [NSThread sleepForTimeInterval:2];
    NSLog(@"load word list");
}

-(void) loadSentenceList {
    [NSThread sleepForTimeInterval:2];
    NSLog(@"load sentence list");
}

- (void)segmentedControlDidChange:(MCSegmentedControl *)sender 
{
    if (isFirstLoad) {
        return;
    }
    if ([sender selectedSegmentIndex] == 0) {
        [self loadHUD:[NSNumber numberWithInt:1]];
    } else {
        [self loadHUD:[NSNumber numberWithInt:2]];
    }
}

-(void) dealloc {
    [wordListView release];
    [HUD release];
    [super dealloc];
}

@end
