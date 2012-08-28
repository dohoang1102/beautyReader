//
//  FavoritesView.h
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WordListView;
@class SentenceListView;
@interface FavoritesView : UIView {
    WordListView *wordListView;
    SentenceListView *sentenceView;
    NSArray *wordList;
    NSArray *sentenceList;
}

@end
