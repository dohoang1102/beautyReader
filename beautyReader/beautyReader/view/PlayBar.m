//
//  PlayBar.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PlayBar.h"

@interface PlayBar()

-(void) statTimer;

-(void) endTimer;

-(void) updateProgress;

-(void) updateProgress:(id) sender;

@end

@implementation PlayBar

@synthesize delegate,hasBegan;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, kHeight)];
        backGroundView.backgroundColor = [UIColor blackColor];
        backGroundView.alpha = 0.5f;
        [self addSubview:backGroundView];
        [backGroundView release];
        
        startTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 50, kHeight-10)];
        startTimeLabel.backgroundColor = [UIColor clearColor];
        startTimeLabel.textColor = [UIColor whiteColor];
        startTimeLabel.textAlignment = UITextAlignmentCenter;
        startTimeLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        startTimeLabel.text = @"00:00";
        [self addSubview:startTimeLabel];
        [startTimeLabel release];
        
        slider = [[UISlider alloc] initWithFrame:CGRectMake(55, 10, frame.size.width -115, 10)];
        slider.minimumValue = 0;
        slider.maximumValue = 100;
        slider.value = 0;
        [slider addTarget:self action:@selector(updateProgress:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:slider];
        
        totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.size.width+slider.frame.origin.x+13, 5, 50, kHeight-10)];
        totalTimeLabel.backgroundColor = [UIColor clearColor];
        totalTimeLabel.textColor = [UIColor whiteColor];
        totalTimeLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        totalTimeLabel.text = @"00:00";
        [self addSubview:totalTimeLabel];
        [totalTimeLabel release];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//设置播放文件
-(void) setAudioFile:(NSString*) audioFile {
    if (!audioFile) {
        return;
    }
    if (player) {
        [player stop];
        [player release];
        player = nil;
    }
    NSURL *audioURL = [[NSBundle mainBundle] URLForResource:audioFile withExtension:@"mp3"];
    NSError *error = nil;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:&error];
    if (error) {
        ELog(@"prepare to play file(%@) error :%@",audioFile,[error localizedDescription]);
        return;
    }
    [player prepareToPlay];
    totalTimeLabel.text = [NSString stringWithFormat:@"-%02d:%02d",(int)(round(player.duration))/60,(int)(round(player.duration))%60];
    slider.maximumValue = player.duration;
}

//播放
-(void) play {
    if (player) {
        [player play];
        hasBegan = YES;
    }
    [self statTimer];
}

//暂停
-(void) pause {
    if (player && [player isPlaying]) {
        [player pause];
        [self endTimer];
    }
}

//停止
-(void) stop {
    if (player && [player isPlaying]) {
        [player stop];
        [self endTimer];
    }
}

-(void) dealloc {
    DBLog(@"%@",NSStringFromSelector(_cmd));
    [self stop];
    [player release];
    [super dealloc];
}

#pragma mark - delegate

-(void) statTimer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

-(void) endTimer {
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

-(void) updateProgress {
    slider.value = round(player.currentTime);
    startTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)round(player.currentTime)/60,(int)round(player.currentTime)%60];
    float leftTime = player.duration - player.currentTime;
    NSString *leftTimes = [NSString stringWithFormat:@"-%02d:%02d",(int)round(leftTime)/60,(int)round(leftTime)%60];
    totalTimeLabel.text = leftTimes;
}

-(void) updateProgress:(id) sender {
    player.currentTime = slider.value;
    startTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)round(slider.value)/60,(int)round(slider.value)%60];
    float leftTime = player.duration - slider.value;
    NSString *leftTimes = [NSString stringWithFormat:@"-%02d:%02d",(int)round(leftTime)/60,(int)round(leftTime)%60];
    totalTimeLabel.text = leftTimes;
    if (delegate && [delegate respondsToSelector:@selector(playBarChanged:)]) {
        [delegate playBarChanged:slider.value];
    }
}

@end
