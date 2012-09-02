//
//  GameFirstLevelView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameFirstLevelView.h"
#import "CardView.h"
#import "GameFirstLevelViewController.h"
#import "WORD.h"
#import "CHAPTER.h"
#import "FXLabel.h"

NSString *GameReadyNotification = @"GameReadyNotification";//游戏准备开始通知

@interface GameFirstLevelView()

//打乱顺序
-(void) mixUpOrder:(NSTimer*)timer;

//卡片翻转之后调用
-(void) cardTakeOver:(NSNotification*)notification;

@end

@implementation GameFirstLevelView

@synthesize controller,totalTimeLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //添加暂停按钮
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pauseButton setTitle:@"暂停" forState:UIControlStateNormal];
    [pauseButton addTarget:controller action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
    pauseButton.frame = CGRectMake(10, 10, 50, 20);
    [self addSubview:pauseButton];
    
    //添加倒数计时器标签
    totalTimeLabel = [[FXLabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    totalTimeLabel.center = CGPointMake(rect.size.width/2, 20);
    totalTimeLabel.backgroundColor = [UIColor clearColor];
    totalTimeLabel.shadowColor = [UIColor blackColor];
    totalTimeLabel.shadowOffset = CGSizeZero;
    totalTimeLabel.shadowBlur = 20.0f;
    totalTimeLabel.font = [UIFont boldSystemFontOfSize:22.0f];
    totalTimeLabel.innerShadowColor = [UIColor yellowColor];
    totalTimeLabel.innerShadowOffset = CGSizeMake(1.0f, 2.0f);
    totalTimeLabel.gradientStartColor = [UIColor redColor];
    totalTimeLabel.gradientEndColor = [UIColor yellowColor];
    totalTimeLabel.gradientStartPoint = CGPointMake(0.0f, 0.5f);
    totalTimeLabel.gradientEndPoint = CGPointMake(1.0f, 0.5f);
    totalTimeLabel.oversampling = 2;
    totalTimeLabel.hidden = YES;
    [self addSubview:totalTimeLabel];
    [totalTimeLabel release];
    //获取随机的单词数组
    NSMutableArray *wordArray = [NSMutableArray array];
    for (WORD *word in controller.chapter.words) {
        [wordArray addObject:word];
    }
    NSArray *radomWordArray = [SystemUtil randomArray:wordArray randomFactor:2];
    if (!radomWordArray) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未加载到游戏数据" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    WORD *word1 = [radomWordArray objectAtIndex:0];
    NSArray *word1Arr = [word1.content componentsSeparatedByString:@"|"];
    if (!word1Arr || word1Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card1 = [[CardView alloc] initWithFrame:CGRectMake(-130, -80, 120, 80) title:[word1Arr objectAtIndex:0]];
    card1.identifier = 1;
    card1.isOn = YES;
    card2 = [[CardView alloc] initWithFrame:CGRectMake(-130, -80, 120, 80) title:[word1Arr objectAtIndex:(word1Arr.count -1)]];
    card2.identifier = 1;
    card2.isOn = YES;
    
    WORD *word2 = [radomWordArray objectAtIndex:1];
    NSArray *word2Arr = [word2.content componentsSeparatedByString:@"|"];
    if (!word2Arr || word2Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card3 = [[CardView alloc] initWithFrame:CGRectMake(-130, -80, 120, 80) title:[word2Arr objectAtIndex:0]];
    card3.identifier = 2;
    card3.isOn = YES;
    card4 = [[CardView alloc] initWithFrame:CGRectMake(-130, -80, 120, 80) title:[word2Arr objectAtIndex:(word2Arr.count -1)]];
    card4.identifier = 2;
    card4.isOn = YES;
    
    [self addSubview:card1];
    [self addSubview:card2];
    [self addSubview:card3];
    [self addSubview:card4];
    [card1 release];
    [card2 release];
    [card3 release];
    [card4 release];
    
    //将四个卡片坐标存入数组中
    cardPositionArray = [[NSMutableArray alloc] init];
    //发牌计时器
    initialTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(showCardWithAnimation) userInfo:nil repeats:YES];
    //注册卡片翻转后事件通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cardTakeOver:) name:FlipNotification object:nil];
    
    //初始状态，卡片不允许点击
    card1.userInteractionEnabled = NO;
    card2.userInteractionEnabled = NO;
    card3.userInteractionEnabled = NO;
    card4.userInteractionEnabled = NO;
}

-(void) showCardWithAnimation {
    if (cardCount >=4) {
        [initialTimer invalidate];
        initialTimer = nil;
    }
    cardCount ++;
    switch (cardCount) {
        case 1:
            [UIView animateWithDuration:.3f animations:^(void) {
                card1.frame = CGRectMake(50, 60, card1.frame.size.width, card1.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card1.frame]];
            }];
            break;
        case 2:
            [UIView animateWithDuration:.3f animations:^(void) {
                card2.frame = CGRectMake(card1.frame.size.width + 120, 60, card2.frame.size.width, card2.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card2.frame]];
            }];
            break;
        case 3:
            [UIView animateWithDuration:.3f animations:^(void) {
                card3.frame = CGRectMake(50, 180, card3.frame.size.width, card3.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card3.frame]];
            }];
            break;
        case 4:
            [UIView animateWithDuration:.3f animations:^(void) {
                card4.frame = CGRectMake(card3.frame.size.width + 120, 180, card4.frame.size.width, card4.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card4.frame]];
            }];
            break;
        case 5:
            mixUpOrderTimer = [NSTimer scheduledTimerWithTimeInterval:.2f target:self selector:@selector(mixUpOrder:) userInfo:nil repeats:YES];
            break;
        default:
            break;
    }
}

//打乱顺序
-(void) mixUpOrder:(NSTimer*)timer {
    mixUpTime+=0.2f;
    NSArray *cardNewArray = [SystemUtil randomArray:cardPositionArray randomFactor:4];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.15f];
    card1.frame =[(NSValue*)[cardNewArray objectAtIndex:0] CGRectValue];
    card2.frame =[(NSValue*)[cardNewArray objectAtIndex:1] CGRectValue];
    card3.frame =[(NSValue*)[cardNewArray objectAtIndex:2] CGRectValue];
    card4.frame =[(NSValue*)[cardNewArray objectAtIndex:3] CGRectValue];
    [UIView commitAnimations];
    if (mixUpTime >=2.5f) {
        [mixUpOrderTimer invalidate];
        mixUpOrderTimer = nil;
        //发送游戏准备完毕通知
        [[NSNotificationCenter defaultCenter] postNotificationName:GameReadyNotification object:nil];
    }
}

//更新计时器
-(void) updateTimerLabel {
    totalTimeLabel.text = [NSString stringWithFormat:@"倒计时:%ds",controller.totalTime];
}

//关闭所有的牌
-(void) takeOverAllCards {
    card1.userInteractionEnabled = YES;
    card2.userInteractionEnabled = YES;
    card3.userInteractionEnabled = YES;
    card4.userInteractionEnabled = YES;
    if (card1.isOn) {
        [card1 cardFlip:nil];
    }
    if (card2.isOn) {
        [card2 cardFlip:nil];
    }
    if (card3.isOn) {
        [card3 cardFlip:nil];
    }
    if (card4.isOn) {
        [card4 cardFlip:nil];
    }
}

//卡片翻转之后调用
-(void) cardTakeOver:(NSNotification*)notification {
    CardView *newOpenCard = notification.object;
    if (lastOpenCard == newOpenCard) {
        lastOpenCard = nil;
        return;
    }
     if (!newOpenCard.isOn) {
         return;
     }
    if (!lastOpenCard) {//当前没有翻开的卡片
        lastOpenCard = newOpenCard;
        return;
    }
    if (lastOpenCard.identifier == newOpenCard.identifier && lastOpenCard != newOpenCard) {//翻开的为同类卡片
        disapparCard++;
        [lastOpenCard removeFromSuperview];
        lastOpenCard = nil;
        [newOpenCard removeFromSuperview];
        newOpenCard = nil;
        if (disapparCard == 2) {//翻牌完毕,显示结果
            [controller showGameResult];
        }
    } else {//不为同一类，都翻转过去
        if (lastOpenCard && newOpenCard && lastOpenCard != newOpenCard) {
            [lastOpenCard cardFlip:nil];
            [newOpenCard cardFlip:nil];
            lastOpenCard = nil;
        } else {
            [newOpenCard cardFlip:nil];
        }
    }
}

//暂停发牌或者打乱顺序
-(void) pauseTimer {
    if (initialTimer) {
        [initialTimer invalidate];
        initialTimer = nil;
    }
    if(mixUpOrderTimer) {
        [mixUpOrderTimer invalidate];
        mixUpOrderTimer = nil;
    }
}

//恢复定时器
-(void) resumeTimer {
    if (cardCount >= 5) {//发牌完毕
    } else {
        initialTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(showCardWithAnimation) userInfo:nil repeats:YES];
        return;
    }
    if (mixUpTime >= 2.5) {//顺序打乱
    } else {
        mixUpOrderTimer = [NSTimer scheduledTimerWithTimeInterval:.2f target:self selector:@selector(mixUpOrder:) userInfo:nil repeats:YES];
        return;
    }
}

-(void) dealloc {
    [cardPositionArray release];
    [super dealloc];
}

@end
