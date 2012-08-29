//
//  SentenceListView.h
//  beautyReader
//  妙句列表
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FROM_FAVORITES,
    FROM_READER
} SENTENCE_CHANNEL;

@interface SentenceListView : UITableView<UITableViewDelegate,UITableViewDataSource> {
    NSArray *sentenceListArray;
    SENTENCE_CHANNEL channel;
}

@property (nonatomic,retain) NSArray *sentenceListArray;
@property (nonatomic,assign) SENTENCE_CHANNEL channel;

@end
