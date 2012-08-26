//
//  MainView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@interface MainView : UIView {
    MainViewController *controller;
}

@property (nonatomic,assign) MainViewController *controller;

@end
