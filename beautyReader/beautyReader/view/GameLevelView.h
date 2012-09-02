//
//  GameLevelView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameLevelViewController.h"

@interface GameLevelView : UIView {
    GameLevelViewController *controller;
}

@property (nonatomic,assign) GameLevelViewController *controller;

-(id) initWithFrame:(CGRect)frame controller:(GameLevelViewController*)_gameController;

-(UIButton*)createLevelButtonWithTitle:(NSString*) title level:(int)level;

-(void) beginGame:(id)sender;

-(void) goBack;

-(void) reCreateButton;

@end
