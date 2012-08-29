//
//  FavoritesView.h
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define kSegementHeight      44.0f
#define kSegementMaginTop   10.0f

@class WordListView;
@class SentenceListView;
@class FavoritesViewController;
@interface FavoritesView : UIView<MBProgressHUDDelegate,UIGestureRecognizerDelegate> {
    WordListView *wordListView;
    SentenceListView *sentenceView;
    NSArray *wordList;
    NSArray *sentenceList;
    MBProgressHUD *HUD;
    FavoritesViewController *controller;
    BOOL isFirstLoad;
    UILabel *noResultsLabel;
    BOOL isFullScreen;
    BOOL flag;
}

@property (nonatomic,assign) FavoritesViewController *controller;
@property (nonatomic,retain) NSArray *wordList;
@property (nonatomic,retain) NSArray *sentenceList;

@end
