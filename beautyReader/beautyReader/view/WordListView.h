//
//  WordListView.h
//  beautyReader
//  单词列表
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordListView : UITableView<UITableViewDelegate,UITableViewDataSource> {
    NSArray *wordListArray;
}

@property (nonatomic,retain) NSArray *wordListArray;

@end
