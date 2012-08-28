//
//  ToolsBar.h
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kToolBarHeight      44
@protocol ToolBarDelegate;
@interface ToolsBar : UIView {
    id<ToolBarDelegate> delegate;
    int chapterContentType;//文章显示内容 0:英文 1:中文 2中英文
}

@property (nonatomic,assign) id<ToolBarDelegate> delegate;

-(void) subjectButtonPressed:(id) sender;
-(void) chapterChangeButtonPressed:(id) sender;
-(void) sentenceButtonPressed:(id) sender;
-(void) gameButtonPressed:(id) sender;

@end

@protocol ToolBarDelegate <NSObject>

@optional

//主题按钮回调
-(void) subjectTouchEvent;

//文章切换
-(void) chapterTypeTouchEvent:(int) eventType;

//妙语回调
-(void) sentenceTouchEvent;

//游戏回调
-(void) gameTouchEvent;

@end
