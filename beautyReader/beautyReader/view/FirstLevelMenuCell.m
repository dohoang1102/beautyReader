//
//  FirstLevelMenuCell.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstLevelMenuCell.h"
#import "SUBJECT.h"

@implementation FirstLevelMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        sequenceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width/4.5, 20)];
        sequenceLabel.font = [UIFont systemFontOfSize:15.0f];
        sequenceLabel.backgroundColor = [UIColor clearColor];
        sequenceLabel.textAlignment = UITextAlignmentRight;
        [self addSubview:sequenceLabel];
        [sequenceLabel release];
        
        subjectNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(sequenceLabel.frame.size.width+sequenceLabel.frame.origin.x+15, 10, self.frame.size.width/4.5*3-35, 20)];
        subjectNameLabel.font = [UIFont systemFontOfSize:15.0f];
        subjectNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:subjectNameLabel];
        [subjectNameLabel release];
        
        subjectTransLabel = [[UILabel alloc] initWithFrame:CGRectMake(subjectNameLabel.frame.origin.x, subjectNameLabel.frame.size.height+subjectNameLabel.frame.origin.y+5, subjectNameLabel.frame.size.width, 20)];
        subjectTransLabel.font = [UIFont systemFontOfSize:15.0f];
        subjectTransLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:subjectTransLabel];
        [subjectTransLabel release];
        
        subjectInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(subjectTransLabel.frame.origin.x, subjectTransLabel.frame.size.height+subjectTransLabel.frame.origin.y+5, subjectTransLabel.frame.size.width, 20)];
        subjectInfoLabel.font = [UIFont systemFontOfSize:15.0f];
        subjectInfoLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:subjectInfoLabel];
        [subjectInfoLabel release];
    }
    return self;
}

-(void) resizeCell:(SUBJECT*)subject {
    sequenceLabel.text = [NSString stringWithFormat:@"Unit %d",[(NSNumber*)subject.sequence intValue]];
    subjectNameLabel.text = subject.subjectName;
    subjectTransLabel.text = subject.subjectTranslation;
    subjectInfoLabel.text = subject.subjectInfo;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
