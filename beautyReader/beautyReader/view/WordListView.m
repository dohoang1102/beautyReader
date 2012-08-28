//
//  WordListView.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WordListView.h"
#import "WORD.h"

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
        contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        [cell.contentView addSubview:contentLabel];
        [contentLabel release];
        //设置收藏按钮
        UIButton *favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    contentLabl.frame = CGRectMake(10, 5, cell.frame.size.width-20, wordSize.height+10);
    [contentLabl sizeToFit];
    contentLabl.text = wordString;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(void) markAsFavorite:(id)sender {
    
}

@end
