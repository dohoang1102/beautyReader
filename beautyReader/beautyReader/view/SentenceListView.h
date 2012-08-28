//
//  SentenceListView.h
//  beautyReader
//  妙句列表
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SentenceListView : UITableView<UITableViewDelegate,UITableViewDataSource> {
    NSArray *sentenceListArray;
}

@property (nonatomic,retain) NSArray *sentenceListArray;


@end
