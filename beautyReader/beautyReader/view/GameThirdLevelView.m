//
//  GameThirdLevelView.m
//  beautyReader
//
//  Created by zhu zhanping on 12-9-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameThirdLevelView.h"
#import "CardView.h"
#import "GameThirdLevelViewController.h"
#import "WORD.h"
#import "CHAPTER.h"
#import "FXLabel.h"

NSString *ThGameReadyNotification = @"ThGameReadyNotification";

@interface GameThirdLevelView()

//打乱顺序
-(void) mixUpOrder:(NSTimer*)timer;

//卡片翻转之后调用
-(void) cardTakeOver:(NSNotification*)notification;

@end

@implementation GameThirdLevelView

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
    NSArray *radomWordArray = [SystemUtil randomArray:wordArray randomFactor:6];
    if (!radomWordArray) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未加载到游戏数据" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    //------------------第一组-------------------------
    WORD *word1 = [radomWordArray objectAtIndex:0];
    NSArray *word1Arr = [word1.content componentsSeparatedByString:@"|"];
    if (!word1Arr || word1Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card1 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word1Arr objectAtIndex:0]];
    card1.identifier = 1;
    card1.isOn = YES;
    card2 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word1Arr objectAtIndex:(word1Arr.count -1)]];
    card2.identifier = 1;
    card2.isOn = YES;
    
    //------------------第二组-------------------------
    WORD *word2 = [radomWordArray objectAtIndex:1];
    NSArray *word2Arr = [word2.content componentsSeparatedByString:@"|"];
    if (!word2Arr || word2Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card3 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word2Arr objectAtIndex:0]];
    card3.identifier = 2;
    card3.isOn = YES;
    card4 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word2Arr objectAtIndex:(word2Arr.count -1)]];
    card4.identifier = 2;
    card4.isOn = YES;
    
    //------------------第三组-------------------------
    WORD *word3 = [radomWordArray objectAtIndex:2];
    NSArray *word3Arr = [word3.content componentsSeparatedByString:@"|"];
    if (!word3Arr || word3Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card5 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word3Arr objectAtIndex:0]];
    card5.identifier = 3;
    card5.isOn = YES;
    card6 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word3Arr objectAtIndex:(word3Arr.count -1)]];
    card6.identifier = 3;
    card6.isOn = YES;
    
    //------------------第四组-------------------------
    WORD *word4 = [radomWordArray objectAtIndex:3];
    NSArray *word4Arr = [word4.content componentsSeparatedByString:@"|"];
    if (!word4Arr || word4Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card7 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word4Arr objectAtIndex:0]];
    card7.identifier = 4;
    card7.isOn = YES;
    card8 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word4Arr objectAtIndex:(word4Arr.count -1)]];
    card8.identifier = 4;
    card8.isOn = YES;
    
    //------------------第五组-------------------------
    WORD *word5 = [radomWordArray objectAtIndex:4];
    NSArray *word5Arr = [word5.content componentsSeparatedByString:@"|"];
    if (!word5Arr || word5Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card9 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word5Arr objectAtIndex:0]];
    card9.identifier = 5;
    card9.isOn = YES;
    card10 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word5Arr objectAtIndex:(word5Arr.count -1)]];
    card10.identifier = 5;
    card10.isOn = YES;
    
    //------------------第六组-------------------------
    WORD *word6 = [radomWordArray objectAtIndex:5];
    NSArray *word6Arr = [word6.content componentsSeparatedByString:@"|"];
    if (!word6Arr || word6Arr.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载游戏数据失败" delegate:controller cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [alert release];
        return;
    }
    
    card11 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word6Arr objectAtIndex:0]];
    card11.identifier = 6;
    card11.isOn = YES;
    card12 = [[CardView alloc] initWithFrame:CGRectMake(-110, -60, 100, 60) title:[word6Arr objectAtIndex:(word6Arr.count -1)]];
    card12.identifier = 6;
    card12.isOn = YES;
    
    [self addSubview:card1];
    [self addSubview:card2];
    [self addSubview:card3];
    [self addSubview:card4];
    [self addSubview:card5];
    [self addSubview:card6];
    [self addSubview:card7];
    [self addSubview:card8];
    [self addSubview:card9];
    [self addSubview:card10];
    [self addSubview:card11];
    [self addSubview:card12];
    [card1 release];
    [card2 release];
    [card3 release];
    [card4 release];
    [card5 release];
    [card6 release];
    [card7 release];
    [card8 release];
    [card9 release];
    [card10 release];
    [card11 release];
    [card12 release];
    
    //将十二个卡片坐标存入数组中
    cardPositionArray = [[NSMutableArray alloc] init];
    //发牌计时器
    initialTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(showCardWithAnimation) userInfo:nil repeats:YES];
    //注册卡片翻转后事件通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cardTakeOver:) name:FlipNotification object:nil];
}

-(void) showCardWithAnimation {
    if (cardCount >=12) {
        [initialTimer invalidate];
        initialTimer = nil;
    }
    cardCount ++;
    switch (cardCount) {
        case 1:
            [UIView animateWithDuration:.3f animations:^(void) {
                card1.frame = CGRectMake(20, 40, card1.frame.size.width, card1.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card1.frame]];
            }];
            break;
        case 2:
            [UIView animateWithDuration:.3f animations:^(void) {
                card2.frame = CGRectMake(card1.frame.size.width + card1.frame.origin.x+13, 40, card2.frame.size.width, card2.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card2.frame]];
            }];
            break;
        case 3:
            [UIView animateWithDuration:.3f animations:^(void) {
                card3.frame = CGRectMake(card2.frame.size.width+card2.frame.origin.x+13, 40, card3.frame.size.width, card3.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card3.frame]];
            }];
            break;
        case 4:
            [UIView animateWithDuration:.3f animations:^(void) {
                card4.frame = CGRectMake(card3.frame.size.width + card3.frame.origin.x+13, 40, card4.frame.size.width, card4.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card4.frame]];
            }];
            break;
        case 5:
            [UIView animateWithDuration:.3f animations:^(void) {
                card5.frame = CGRectMake(20, 120, card5.frame.size.width, card5.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card5.frame]];
            }];
            break;
        case 6:
            [UIView animateWithDuration:.3f animations:^(void) {
                card6.frame = CGRectMake(card5.frame.size.width + card5.frame.origin.x+13, 120, card6.frame.size.width, card6.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card6.frame]];
            }];
            break;
        case 7:
            [UIView animateWithDuration:.3f animations:^(void) {
                card7.frame = CGRectMake(card6.frame.size.width + card6.frame.origin.x+13, 120, card7.frame.size.width, card7.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card7.frame]];
            }];
            break;
        case 8:
            [UIView animateWithDuration:.3f animations:^(void) {
                card8.frame = CGRectMake(card7.frame.size.width + card7.frame.origin.x+13, 120, card8.frame.size.width, card8.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card8.frame]];
            }];
            break;
        case 9:
            [UIView animateWithDuration:.3f animations:^(void) {
                card9.frame = CGRectMake(20, 200, card9.frame.size.width, card9.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card9.frame]];
            }];
            break;
        case 10:
            [UIView animateWithDuration:.3f animations:^(void) {
                card10.frame = CGRectMake(card9.frame.size.width + card9.frame.origin.x+13, 200, card10.frame.size.width, card10.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card10.frame]];
            }];
            break;
        case 11:
            [UIView animateWithDuration:.3f animations:^(void) {
                card11.frame = CGRectMake(card10.frame.size.width + card10.frame.origin.x+13, 200, card11.frame.size.width, card11.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card11.frame]];
            }];
            break;
        case 12:
            [UIView animateWithDuration:.3f animations:^(void) {
                card12.frame = CGRectMake(card11.frame.size.width + card11.frame.origin.x+13, 200, card12.frame.size.width, card12.frame.size.height);
            } completion:^(BOOL finished) {
                [cardPositionArray addObject:[NSValue valueWithCGRect:card12.frame]];
            }];
            break;
        case 13:
            mixUpOrderTimer = [NSTimer scheduledTimerWithTimeInterval:.2f target:self selector:@selector(mixUpOrder:) userInfo:nil repeats:YES];
            break;
        default:
            break;
    }
}

//打乱顺序
-(void) mixUpOrder:(NSTimer*)timer {
    mixUpTime+=0.2f;
    NSArray *cardNewArray = [SystemUtil randomArray:cardPositionArray randomFactor:12];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.15f];
    card1.frame =[(NSValue*)[cardNewArray objectAtIndex:0] CGRectValue];
    card2.frame =[(NSValue*)[cardNewArray objectAtIndex:1] CGRectValue];
    card3.frame =[(NSValue*)[cardNewArray objectAtIndex:2] CGRectValue];
    card4.frame =[(NSValue*)[cardNewArray objectAtIndex:3] CGRectValue];
    card5.frame =[(NSValue*)[cardNewArray objectAtIndex:4] CGRectValue]; 
    card6.frame =[(NSValue*)[cardNewArray objectAtIndex:5] CGRectValue]; 
    card7.frame =[(NSValue*)[cardNewArray objectAtIndex:6] CGRectValue]; 
    card8.frame =[(NSValue*)[cardNewArray objectAtIndex:7] CGRectValue]; 
    card9.frame =[(NSValue*)[cardNewArray objectAtIndex:8] CGRectValue]; 
    card10.frame =[(NSValue*)[cardNewArray objectAtIndex:9] CGRectValue]; 
    card11.frame =[(NSValue*)[cardNewArray objectAtIndex:10] CGRectValue]; 
    card12.frame =[(NSValue*)[cardNewArray objectAtIndex:11] CGRectValue]; 
    [UIView commitAnimations];
    if (mixUpTime >=2.5f) {
        [mixUpOrderTimer invalidate];
        mixUpOrderTimer = nil;
        //发送游戏准备完毕通知
        [[NSNotificationCenter defaultCenter] postNotificationName:ThGameReadyNotification object:nil];
    }
}

//更新计时器
-(void) updateTimerLabel {
    totalTimeLabel.text = [NSString stringWithFormat:@"倒计时:%ds",controller.totalTime];
}

//关闭所有的牌
-(void) takeOverAllCards {
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
    if (card5.isOn) {
        [card5 cardFlip:nil];
    }
    if (card6.isOn) {
        [card6 cardFlip:nil];
    }
    if (card7.isOn) {
        [card7 cardFlip:nil];
    }
    if (card8.isOn) {
        [card8 cardFlip:nil];
    }
    if (card9.isOn) {
        [card9 cardFlip:nil];
    }
    if (card10.isOn) {
        [card10 cardFlip:nil];
    }
    if (card11.isOn) {
        [card11 cardFlip:nil];
    }
    if (card12.isOn) {
        [card12 cardFlip:nil];
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
        if (disapparCard == 6) {//翻牌完毕,显示结果
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
    if (cardCount >= 13) {//发牌完毕
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FlipNotification object:nil];
    [cardPositionArray release];
    [super dealloc];
}

@end
