//
//  WordTranslateView.h
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	LEFT_UP,
	LEFT_DOWN,
	RIGHT_UP,
    RIGHT_DOWN
} ViewDirector;

@class WORD;

#define WORD_TRANS_VIEW_FRAME   CGRectMake(0, 0, 150, 100)  
#define WORD_FONT  [UIFont systemFontOfSize:14.0f] 
@interface WordTranslateView : UIView {
    WORD *word;
    UIButton *favoritesButton;
    UILabel *wordLabel;
    ViewDirector director;//根据不同的方向，设置不同的气泡图片
}

@property (nonatomic,retain) WORD *word;
@property (nonatomic,assign) ViewDirector director;

@end

