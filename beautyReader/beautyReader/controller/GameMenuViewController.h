//
//  GameMenuViewController.h
//  beautyReader
//
//  Created by superjoo on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAPTER;
@interface GameMenuViewController : UIViewController {
    CHAPTER *chapter;
}

@property (nonatomic,retain) CHAPTER *chapter;

-(void) goBack;

-(void) showHelpInfo;

@end
