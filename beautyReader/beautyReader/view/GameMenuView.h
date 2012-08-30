//
//  GameMenuView.h
//  beautyReader
//
//  Created by superjoo on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameMenuViewController;
@interface GameMenuView : UIView {
    GameMenuViewController *controller;
}

@property (nonatomic,assign) GameMenuViewController *controller;

@end
