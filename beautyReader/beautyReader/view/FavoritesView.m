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
#import "ChapterService.h"
#import "SentenceListView.h"

@interface FavoritesView()

-(void) reloadWordListView;

-(void) reloadSentenceListView;

-(void) wantsFullScreen;

-(void) reDrawCurrentView;

@end

@implementation FavoritesView

@synthesize controller,wordList,sentenceList;

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
	segmentedControl.frame = CGRectMake(10.0f, kSegementMaginTop, self.frame.size.width-20, kSegementHeight);
	[self addSubview:segmentedControl];
	[segmentedControl addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.tintColor = [UIColor colorWithRed:.0 green:.6 blue:.0 alpha:1.0];
	segmentedControl.selectedItemColor   = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;
	segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
	[segmentedControl release];
    
    //添加无结果标签
    noResultsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.frame.size.width, 25)];
    noResultsLabel.backgroundColor = [UIColor clearColor];
    noResultsLabel.font = [UIFont systemFontOfSize:16.0f];
    noResultsLabel.hidden = YES;
    noResultsLabel.textAlignment = UITextAlignmentCenter;
    [self addSubview:noResultsLabel];
    [noResultsLabel release];
    
    //添加妙语列表
    sentenceView = [[SentenceListView alloc] initWithFrame:CGRectMake(0,  segmentedControl.frame.origin.y+segmentedControl.frame.size.height+5, self.frame.size.width, self.frame.size.height - segmentedControl.frame.origin.y-segmentedControl.frame.size.height-5) style:UITableViewStylePlain];
    [self addSubview:sentenceView];
    sentenceView.hidden = YES;
    sentenceView.channel = FROM_FAVORITES;
    sentenceView.dataSource = sentenceView;
    sentenceView.delegate = sentenceView;
    
    //添加单词列表
    wordListView = [[WordListView alloc] initWithFrame:CGRectMake(0,  segmentedControl.frame.origin.y+segmentedControl.frame.size.height+5, self.frame.size.width, self.frame.size.height - segmentedControl.frame.origin.y-segmentedControl.frame.size.height-5) style:UITableViewStylePlain];
    [self addSubview:wordListView];
    wordListView.hidden = YES;
    wordListView.dataSource = wordListView;
    wordListView.delegate = wordListView;
    //初始化HUD
    [self performSelector:@selector(loadHUD:) withObject:[NSNumber numberWithInt:1] afterDelay:.2f];
    isFirstLoad = NO;
    
    //添加全屏触发事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wantsFullScreen)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
    [tapGesture release];
}

-(void) loadHUD:(NSNumber*)loadType {
    if ([loadType intValue] == 1) {//查询单词列表
        //if (wordList && [wordList count] > 0) {
        //    [self reloadWordListView];
        //} else {
            [HUD release];
            HUD = [[MBProgressHUD alloc] initWithView:controller.navigationController.view];
            [controller.navigationController.view addSubview:HUD];
            HUD.animationType = MBProgressHUDAnimationZoom;
            HUD.delegate = self;
            HUD.labelText = @"加载中";
            [HUD showWhileExecuting:@selector(loadWordList) onTarget:self withObject:nil animated:YES];
       // }
    } else {//查询句子列表
       // if (sentenceList && [sentenceList count] > 0) {
       //     [self reloadSentenceListView];
       // } else {
            [HUD release];
            HUD = [[MBProgressHUD alloc] initWithView:controller.navigationController.view];
            [controller.navigationController.view addSubview:HUD];
            HUD.animationType = MBProgressHUDAnimationZoom;
            HUD.delegate = self;
            HUD.labelText = @"加载中";
            [HUD showWhileExecuting:@selector(loadSentenceList) onTarget:self withObject:nil animated:YES];
      //  }
    }
}

-(void) loadWordList {
    ChapterService *sercice = [[ChapterService alloc] init];
    self.wordList = [sercice queryFavoritesWords];
    [self performSelectorOnMainThread:@selector(reloadWordListView) withObject:nil waitUntilDone:YES];
    [sercice release];
}

-(void) loadSentenceList {
    ChapterService *sercice = [[ChapterService alloc] init];
    self.sentenceList = [sercice queryFavoritesSentences];
    [self performSelectorOnMainThread:@selector(reloadSentenceListView) withObject:nil waitUntilDone:YES];
    [sercice release];
}

-(void) reloadWordListView {
    if (!wordList || [wordList count] == 0) {
        wordListView.hidden = YES;
        sentenceView.hidden = YES;
        noResultsLabel.hidden = NO;
        noResultsLabel.text = @"未收藏生词";
        return;
    }
    wordListView.hidden = NO;
    noResultsLabel.hidden = YES;
    if (!wordListView.superview) {
        [self addSubview:wordListView];
    }
    wordListView.wordListArray = wordList;
    [wordListView reloadData];
    if (sentenceView.superview) {
        [sentenceView removeFromSuperview];
    }
}

-(void) reloadSentenceListView {
    if (!sentenceList || [sentenceList count] == 0) {
        sentenceView.hidden = YES;
        wordListView.hidden = YES;
        noResultsLabel.hidden = NO;
        noResultsLabel.text = @"未收藏妙句";
        return;
    }
    sentenceView.hidden = NO;
    if (!sentenceView.superview) {
        [self addSubview:sentenceView];
    }
    sentenceView.sentenceListArray = sentenceList;
    [sentenceView reloadData];
    if (wordListView.superview) {
        [wordListView removeFromSuperview];
    }
}

-(void) wantsFullScreen {
    if (!isFullScreen) {
        [self fullScreenView];
    } else {
        [self resetFullScreenView];
    }
    isFullScreen = !isFullScreen;
    [self reDrawCurrentView];
}

-(void) fullScreenView {
    [UIView animateWithDuration:.3 animations:^(void){
        CGRect rect = [UIApplication sharedApplication].keyWindow.frame;
        rect.origin.y = rect.origin.y - (kSegementHeight+self.controller.navigationController.navigationBar.frame.size.height-kSegementMaginTop);
        rect.size.height = rect.size.height + kSegementHeight+self.controller.navigationController.navigationBar.frame.size.height-kSegementMaginTop;
        self.controller.navigationController.view.frame = rect;
        
    } completion:^(BOOL finished){
    }];
}

-(void) resetFullScreenView {
    [UIView animateWithDuration:.3 animations:^(void){
        self.controller.navigationController.view.frame = [UIApplication sharedApplication].keyWindow.frame;
    } completion:^(BOOL finished){
    }];
}

-(void) reDrawCurrentView {
    CGRect appRect = [UIApplication sharedApplication].keyWindow.frame;
    if (isFullScreen) {
        self.frame = CGRectMake(0, kSegementHeight+self.controller.navigationController.navigationBar.frame.size.height-kSegementMaginTop, appRect.size.width, appRect.size.height+kSegementHeight+self.controller.navigationController.navigationBar.frame.size.height-kSegementMaginTop);
    } else {
        self.frame = CGRectMake(0, 0, 320, 480);
    }
    sentenceView.frame = CGRectMake(0,  54, self.frame.size.width, self.frame.size.height - 59);
    wordListView.frame = CGRectMake(0,  54, self.frame.size.width, self.frame.size.height - 59);;
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([[touch view] isKindOfClass:[UIButton class]]) {
        return NO;
    }
    if ([[touch view] isKindOfClass:[UISegmentedControl class]]) {
        return NO;
    }
    return YES;
}

-(void) dealloc {
    DBLog(@"%@",NSStringFromSelector(_cmd));
    [wordListView release];
    [sentenceView release];
    [HUD release];
    [wordList release];
    [sentenceList release];
    [super dealloc];
}

@end
