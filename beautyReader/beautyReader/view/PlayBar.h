//
//  PlayBar.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define kHeight     40.0

@protocol PlaBarDelegate;
@interface PlayBar : UIView {
    id<PlaBarDelegate> delegate;
    UILabel *startTimeLabel;
    UILabel *totalTimeLabel;
    NSTimer *timer;
    UISlider *slider;
    UIView *backGroundView;
    AVAudioPlayer *player;
    BOOL hasBegan;
}

@property (nonatomic,assign) id<PlaBarDelegate> delegate;
@property (nonatomic,assign) BOOL hasBegan;

//设置播放文件
-(void) setAudioFile:(NSString*) audioFile;

//播放
-(void) play;

//暂停
-(void) pause;

//停止
-(void) stop;

@end

@protocol PlaBarDelegate <NSObject>

@optional
//播放进度更新时触发
-(void) playBarChanged:(float) playBarValue;

@end