//
//  SecondLevelMenuController.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondLevelMenuController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
    NSArray *dataSourceArray;//二级菜单数据源
    int subjectType;//主题类型　１：春　２：夏　３：秋　４：冬
}

@property (nonatomic,retain) NSArray *dataSourceArray;
@property (nonatomic,assign) int subjectType;

-(void) showFavorite;

@end
