//
//  ReadViewController.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAPTER;
@interface ReadViewController : UIViewController {
    CHAPTER *chapter;
    int subjectType;//主题类型　１：春　２：夏　３：秋　４：冬
    NSArray *wordsArray;
    NSTimer *playBarTimer;
    int playLBarLeftTime;
    NSTimer *wordExplainTimer;
    int wordExplainLeftTime;
}

@property (nonatomic,retain) CHAPTER *chapter;
@property (nonatomic,assign) int subjectType;

-(void) showFavorite;
-(void) back;
-(void) pauseOrPlay:(id)sender;

//解析重点词汇
-(NSArray*)seperatorWords;

//处理单击事件
-(void) handleTapGesture:(UIGestureRecognizer*)gesture;

//处理双击事件
-(void) handleDoubleTapGesture:(UIGestureRecognizer *)gesture;

-(void) plaBarTimerStart;

@end
