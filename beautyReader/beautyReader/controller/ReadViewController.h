//
//  ReadViewController.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCotentFont [UIFont systemFontOfSize:15.0f]
@class CHAPTER;
@class IFTweetLabel;
@interface ReadViewController : UIViewController {
    CHAPTER *chapter;
    int subjectType;//主题类型　１：春　２：夏　３：秋　４：冬
    UIScrollView *scrollView;
    NSArray *wordsArray;
    IFTweetLabel *contentLabel;
}

@property (nonatomic,retain) CHAPTER *chapter;
@property (nonatomic,assign) int subjectType;

-(void) showFavorite;
-(void) back;
-(void) pauseOrPlay:(id)sender;

//解析重点词汇
-(NSArray*)seperatorWords;

@end
