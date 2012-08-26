//
//  SecondLevelMenuView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondLevelMenuController;
@interface SecondLevelMenuView : UITableView {
    SecondLevelMenuController *controller;
}

@property (nonatomic,assign) SecondLevelMenuController *controller;

-(id) initWithFrame:(CGRect)frame delegate:(id)delegate;

@end
