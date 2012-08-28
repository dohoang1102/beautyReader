//
//  ReaderView.h
//  beautyReader
//
//  Created by superjoo on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayBar.h"
#import "ToolsBar.h"
#import "IFTweetLabel.h"
#import "WordTranslateView.h"

#define kCotentFont [UIFont systemFontOfSize:17.0f]
#define kTitleHeight    25

@class ReadViewController;
@interface ReaderView : UIView<UIGestureRecognizerDelegate,PlaBarDelegate,ToolBarDelegate> {
    ReadViewController *controller;
    UIScrollView *scrollView;
    IFTweetLabel *contentLabel;
    PlayBar *playBar;
    ToolsBar *toolBar;
    WordTranslateView *translationView;
    UILabel *titleLabel;
}

@property (nonatomic,assign) ReadViewController *controller;
@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) PlayBar *playBar;
@property (nonatomic,readonly) ToolsBar *toolBar;
@property (nonatomic,retain) WordTranslateView *translationView;

-(void) hideToolBar;

-(void) showToolBar;

-(void) showTranslationView;

-(void) removeTranslationView;

-(void) hideTranslationView;

@end
