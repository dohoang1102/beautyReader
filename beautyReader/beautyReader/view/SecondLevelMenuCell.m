//
//  SecondLevelMenuCell.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondLevelMenuCell.h"
#import "CHAPTER.h"

@implementation SecondLevelMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        sequenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width/4.5, 20)];
        sequenceLabel.font = [UIFont systemFontOfSize:15.0f];
        sequenceLabel.backgroundColor = [UIColor clearColor];
        sequenceLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:sequenceLabel];
        [sequenceLabel release];
        
        chapterNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(sequenceLabel.frame.size.width+sequenceLabel.frame.origin.x+15, 10, self.frame.size.width/4.5*3-35, 0)];
        chapterNameLabel.lineBreakMode = UILineBreakModeWordWrap;
        chapterNameLabel.numberOfLines = 0;
        chapterNameLabel.font = [UIFont systemFontOfSize:15.0f];
        chapterNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:chapterNameLabel];
        [chapterNameLabel release];
        
        chapterTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(chapterNameLabel.frame.origin.x, 0, chapterNameLabel.frame.size.width, 0)];
        chapterTransLabel.lineBreakMode = UILineBreakModeWordWrap;
        chapterTransLabel.numberOfLines = 0;
        chapterTransLabel.font = [UIFont systemFontOfSize:15.0f];
        chapterTransLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:chapterTransLabel];
        [chapterTransLabel release];
    }
    return self;
}

-(void) resizeCell:(CHAPTER*)chapter {
    sequenceLabel.text = chapter.chapterName;
    
    CGSize titleEnSize = [chapter.titleEn sizeWithFont:chapterNameLabel.font constrainedToSize:CGSizeMake(chapterNameLabel.frame.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
    chapterNameLabel.frame = CGRectMake(chapterNameLabel.frame.origin.x, chapterNameLabel.frame.origin.y, chapterNameLabel.frame.size.width, titleEnSize.height);
    chapterNameLabel.text = chapter.titleEn;
    
    CGSize titleZhSize = [chapter.titleZh sizeWithFont:chapterTransLabel.font constrainedToSize:CGSizeMake(chapterTransLabel.frame.size.width, 10000) lineBreakMode:UILineBreakModeWordWrap];
    chapterTransLabel.frame = CGRectMake(chapterTransLabel.frame.origin.x, chapterNameLabel.frame.size.height+chapterNameLabel.frame.origin.y+5, chapterTransLabel.frame.size.width, titleZhSize.height);
    chapterTransLabel.text = chapter.titleZh;
    
    height = chapterTransLabel.frame.size.height + chapterTransLabel.frame.origin.y + 10;
}

-(float) cellHeight {
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
