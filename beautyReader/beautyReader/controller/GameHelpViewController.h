//
//  GameHelpViewController.h
//  beautyReader
//
//  Created by superjoo on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAPTER;
@interface GameHelpViewController : UIViewController {
    CHAPTER *chapter;
}

@property (nonatomic,assign) CHAPTER *chapter;

-(void) goBack;

-(void) showGameLevel;

@end
