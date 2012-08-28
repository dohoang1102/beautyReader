//
//  FavoritesView.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoritesView.h"
#import "MCSegmentedControl.h"

@implementation FavoritesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSArray *items = [NSArray arrayWithObjects:
					  @"生词",
					  @"妙语",
					  //[UIImage imageNamed:@"star.png"],
					  nil];
	MCSegmentedControl *segmentedControl = [[MCSegmentedControl alloc] initWithItems:items];
	segmentedControl.frame = CGRectMake(10.0f, 10.0f, 300.0f, 44.0f);
	[self addSubview:segmentedControl];
	[segmentedControl addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.tintColor = [UIColor colorWithRed:.0 green:.6 blue:.0 alpha:1.0];
	segmentedControl.selectedItemColor   = [UIColor whiteColor];
    segmentedControl.selectedSegmentIndex = 0;
	segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
	[segmentedControl release];
    
    //添加单词列表
    
}

- (void)segmentedControlDidChange:(MCSegmentedControl *)sender 
{
	NSLog(@"%d", [sender selectedSegmentIndex]);
}


@end
