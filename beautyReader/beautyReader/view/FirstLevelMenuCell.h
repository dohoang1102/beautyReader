//
//  FirstLevelMenuCell.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SUBJECT;
@interface FirstLevelMenuCell : UITableViewCell {
    UILabel *sequenceLabel;
    UILabel *subjectNameLabel;
    UILabel *subjectTransLabel;
    UILabel *subjectInfoLabel;
}

-(void) resizeCell:(SUBJECT*)subject;

@end
