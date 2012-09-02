//
//  GameHelperView.h
//  beautyReader
//
//  Created by superjoo on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameHelpViewController;
@interface GameHelperView : UIView {
    UITextView *textView ;
    GameHelpViewController *controller;
}

@property (nonatomic,assign) GameHelpViewController *controller;

-(void) goBack;

-(void) beginGame;

@end
