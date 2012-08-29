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
//测试主题更改使用
    UIColor *navBarTintColor;
}

@property (nonatomic,retain) CHAPTER *chapter;

-(void) showFavorite;

//读取并显示皮肤包
-(void) setSkin;

@end
