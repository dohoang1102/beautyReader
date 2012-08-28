//
//  WordTranslateView.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WordTranslateView.h"
#import "WORD.h"
#import "ChapterService.h"

@interface WordTranslateView()

//收藏按钮按下触发
-(void) changeWordFavorites:(id)sender;

@end

@implementation WordTranslateView

@synthesize director;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    if (!favoritesButton) {
        favoritesButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        favoritesButton.frame = CGRectMake(self.frame.size.width-50, 5, 50, 25);
        if ([self.word.majorWord boolValue]) {
            [favoritesButton setTitle:@"已收藏" forState:UIControlStateNormal];
            favoritesButton.selected = YES;
        } else {
            [favoritesButton setTitle:@"未收藏" forState:UIControlStateNormal];
            favoritesButton.selected = NO;
        }
        [favoritesButton addTarget:self action:@selector(changeWordFavorites:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:favoritesButton];
    }
}
 

-(void) setWord:(WORD *)word_ {
    if (word != word_) {
        word = [word_ retain];
        NSArray *wordLineArr = [word.content componentsSeparatedByString:@"|"];
        NSMutableString *wordString = [NSMutableString string];
        for (int i = 0; i < [wordLineArr count]; i++) {
            [wordString appendString:[wordLineArr objectAtIndex:i]];
            if (i < [wordLineArr count] - 1) {
                [wordString appendString:@"\n"];
            }
        }
        CGSize wordSize = [wordString sizeWithFont:WORD_FONT constrainedToSize:CGSizeMake(WORD_TRANS_VIEW_FRAME.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
        CGFloat viewHeight = WORD_TRANS_VIEW_FRAME.size.height;
        if(viewHeight < wordSize.height) {
            viewHeight = wordSize.height;
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, WORD_TRANS_VIEW_FRAME.size.width, viewHeight);
        if (!wordLabel) {
            wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.height)];
            wordLabel.font = WORD_FONT;
            wordLabel.backgroundColor = [UIColor clearColor];
        }
        wordLabel.numberOfLines = [wordLineArr count];
        wordLabel.text = wordString;
        NSLog(@"%@",wordString);
        [self addSubview:wordLabel];
        [wordLabel release];
    }
}

-(WORD*)word {
    return word;
}


-(void) changeWordFavorites:(id)sender {
    if (favoritesButton.selected) {
        [favoritesButton setTitle:@"未收藏" forState:UIControlStateNormal];
        word.majorWord = [NSNumber numberWithInt:0];
    } else {
        [favoritesButton setTitle:@"已收藏" forState:UIControlStateNormal];
        word.majorWord = [NSNumber numberWithInt:1];
    }
    word.opTime = [NSDate date];
    ChapterService *service = [[[ChapterService alloc] init] autorelease];
    [service updateWords:word];
    favoritesButton.selected = !favoritesButton.selected;
}

-(void) dealloc {
    [word release];
    [super dealloc];
}

@end
