//
//  CardView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *FlipNotification;//视图翻转结束后触发通知

@interface CardView : UIView {
    UIButton *cardButton;
    BOOL isOn;//卡片是否翻开
    int identifier;//卡片编号，每组卡片的编号相同
    NSString *title;//卡片内容
}

@property (assign) int identifier;
@property (assign) BOOL isOn;
@property (nonatomic,retain) NSString *title;

-(void) cardFlip:(id) sender;//卡片翻转动画

-(id) initWithFrame:(CGRect)frame title:(NSString*)_title;

@end
