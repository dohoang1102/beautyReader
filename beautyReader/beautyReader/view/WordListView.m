//
//  WordListView.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WordListView.h"
#import "WORD.h"
#import "ChapterService.h"

@interface WordListView()

-(void) markAsFavorite:(id)sender;

@end

@implementation WordListView

@synthesize wordListArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

-(void) dealloc {
    [wordListArray release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [wordListArray count];
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
        contentLabel.opaque = NO;
        contentLabel.font = [UIFont systemFontOfSize:15.0f];
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
    WORD *word = [wordListArray objectAtIndex:[indexPath row]];
    UIButton *btn = (UIButton*)cell.accessoryView;
    btn.tag = [indexPath row];
    UILabel *contentLabl = (UILabel*)[cell.contentView viewWithTag:10];
    if ([word.majorWord boolValue]) {
        [btn setTitle:@"已收藏" forState:UIControlStateNormal];
    } else {
        [btn setTitle:@"未收藏" forState:UIControlStateNormal];
    }
    NSArray *wordLineArr = [word.content componentsSeparatedByString:@"|"];
    NSMutableString *wordString = [NSMutableString string];
    for (int i = 0; i < [wordLineArr count]; i++) {
        [wordString appendString:[wordLineArr objectAtIndex:i]];
        if (i < [wordLineArr count] - 1) {
            [wordString appendString:@"\n"];
        }
    }
    CGSize wordSize = [wordString sizeWithFont:contentLabl.font constrainedToSize:CGSizeMake(cell.frame.size.width-20, 10000) lineBreakMode:UILineBreakModeWordWrap];
    contentLabl.frame = CGRectMake(10, 0, cell.frame.size.width-20, wordSize.height+10);
    //[contentLabl sizeToFit];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, wordSize.height + 20);
    contentLabl.text = wordString;
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
    WORD *opWord = [wordListArray objectAtIndex:[indexPath row]];
    opWord.majorWord = [NSNumber numberWithBool:NO];
    ChapterService *service = [[[ChapterService alloc] init] autorelease];
    if ([service updateWords:opWord]) {
        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:wordListArray];
        [tmpArray removeObjectAtIndex:[indexPath row]];
        self.wordListArray = tmpArray;
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self endUpdates];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"操作失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

@end
