//
//  GamePauseView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GamePauseDelegate;
@interface GamePauseView : UIView {
    id<GamePauseDelegate> delegate;
}

@property (nonatomic,assign) id<GamePauseDelegate> delegate;

-(void) resume;
-(void) backHome;

@end

@protocol GamePauseDelegate <NSObject>

@optional
-(void) resumeGame;

-(void) backToMenu;

@end