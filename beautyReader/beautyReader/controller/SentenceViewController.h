//
//  SentenceViewController.h
//  beautyReader
//
//  Created by superjoo on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAPTER;
@interface SentenceViewController : UIViewController<UIGestureRecognizerDelegate> {
    CHAPTER *chapter;
    BOOL isFullScreen;
}

@property (nonatomic,retain) CHAPTER *chapter;

-(void) showFavorite;

@end
