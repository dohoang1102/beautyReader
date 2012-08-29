//
//  SubjectMenuView.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectMenuView : UIView<UIGestureRecognizerDelegate> {
    NSString *skin;
    UIButton *sbjButton;
}

-(void) subjectChanged;

-(void) cancel;

@end
