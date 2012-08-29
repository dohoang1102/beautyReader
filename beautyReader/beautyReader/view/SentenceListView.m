//
//  SentenceListView.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SentenceListView.h"
#import "SENTENCE.h"
#import "ChapterService.h"

@implementation SentenceListView

@synthesize sentenceListArray,channel;

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
    // Drawing code
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sentenceListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* wordIdentifier = @"wordIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:wordIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:wordIdentifier] autorelease];
        //设置内容体
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.tag = 10;
        contentLabel.numberOfLines = 0;
        contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.contentView addSubview:contentLabel];
        [contentLabel release];
        //设置收藏按钮
        UIButton *favBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        favBtn.showsTouchWhenHighlighted = YES;
        favBtn.frame = CGRectMake(0, 0, 50, 25);
        [favBtn addTarget:self action:@selector(markAsFavorite:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = favBtn;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SENTENCE *sentence = [sentenceListArray objectAtIndex:[indexPath row]];
    UIButton *btn = (UIButton*)cell.accessoryView;
    btn.tag = [indexPath row];
    UILabel *contentLabl = (UILabel*)[cell.contentView viewWithTag:10];
    if ([sentence.majorSentence boolValue]) {
        btn.selected = YES;
        [btn setTitle:@"已收藏" forState:UIControlStateNormal];
    } else {
        btn.selected = NO;
        [btn setTitle:@"未收藏" forState:UIControlStateNormal];
    }
    NSMutableString *sentenceContent = [NSMutableString string];
    [sentenceContent appendString:sentence.content];
    [sentenceContent appendString:@"\n"];
    [sentenceContent appendString:sentence.translate];
    CGSize wordSize = [sentenceContent sizeWithFont:contentLabl.font constrainedToSize:CGSizeMake(cell.frame.size.width-70, 10000) lineBreakMode:UILineBreakModeWordWrap];
    contentLabl.frame = CGRectMake(10, 5, cell.frame.size.width-70, wordSize.height+10);
    contentLabl.text = sentenceContent;
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, wordSize.height + 20);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(void) markAsFavorite:(id)sender {
    UIButton *markAsFavoriteButton = (UIButton*)sender;
    UITableViewCell *cell = (UITableViewCell*)markAsFavoriteButton.superview;
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    SENTENCE *opSentence = [sentenceListArray objectAtIndex:[indexPath row]];
    if (markAsFavoriteButton.selected) {
        opSentence.majorSentence = [NSNumber numberWithBool:NO];
    } else {
        opSentence.majorSentence = [NSNumber numberWithBool:YES];
    }
    ChapterService *service = [[[ChapterService alloc] init] autorelease];
    if ([service updateSentence:opSentence]) {
        if (channel == FROM_READER) {//阅读界面进入,更新单词
            if (markAsFavoriteButton.selected) {
                [markAsFavoriteButton setTitle:@"未收藏" forState:UIControlStateNormal];
            } else {
                [markAsFavoriteButton setTitle:@"已收藏" forState:UIControlStateNormal];
            }
            markAsFavoriteButton.selected = !markAsFavoriteButton.selected;
        } else {
            NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:sentenceListArray];
            [tmpArray removeObjectAtIndex:[indexPath row]];
            self.sentenceListArray = tmpArray;
            [self beginUpdates];
            [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self endUpdates];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"操作失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

-(void) dealloc {
    [sentenceListArray release];
    [super dealloc];
}

@end
