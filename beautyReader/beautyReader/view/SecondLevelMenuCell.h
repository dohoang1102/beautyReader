//
//  SecondLevelMenuCell.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAPTER;
@interface SecondLevelMenuCell : UITableViewCell {
    UILabel *sequenceLabel;
    UILabel *chapterNameLabel;
    UILabel *chapterTransLabel;
    float height;
}

-(void) resizeCell:(CHAPTER*)chapter;

-(float) cellHeight;

@end
