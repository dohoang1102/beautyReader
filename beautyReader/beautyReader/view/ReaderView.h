//
//  ReaderView.h
//  beautyReader
//
//  Created by superjoo on 8/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayBar.h"

#define kCotentFont [UIFont systemFontOfSize:17.0f]

@class ReadViewController;
@class IFTweetLabel;
@interface ReaderView : UIView<UIGestureRecognizerDelegate,PlaBarDelegate> {
    ReadViewController *controller;
    UIScrollView *scrollView;
    IFTweetLabel *contentLabel;
    PlayBar *playBar;
}

@property (nonatomic,assign) ReadViewController *controller;
@property (nonatomic,readonly) PlayBar *playBar;

@end
