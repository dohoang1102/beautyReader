//
//  FavoritesView.h
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class WordListView;
@class SentenceListView;
@class FavoritesViewController;
@interface FavoritesView : UIView<MBProgressHUDDelegate> {
    WordListView *wordListView;
    SentenceListView *sentenceView;
    NSArray *wordList;
    NSArray *sentenceList;
    MBProgressHUD *HUD;
    FavoritesViewController *controller;
    BOOL isFirstLoad;
}

@property (nonatomic,assign) FavoritesViewController *controller;

@end
