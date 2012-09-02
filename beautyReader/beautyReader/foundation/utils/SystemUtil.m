//
//  SystemUtil.m
//  beautyReader
//
//  Created by zhu zhanping on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SystemUtil.h"

@implementation SystemUtil

+(NSArray*)randomArray:(NSArray*)srcArray randomFactor:(int) factor {
    NSMutableArray *resultArray = [NSMutableArray array];
    NSMutableArray *srcTmpArray = [NSMutableArray arrayWithArray:srcArray];
    if (!srcArray || factor > [srcArray count]) {
        @throw [NSException exceptionWithName:@"" reason:@"" userInfo:nil];
    }
    for (int i = 0; i < factor; i++) {
        int index = arc4random() % (srcArray.count - i);
        [resultArray addObject:[srcTmpArray objectAtIndex:index]];
        [srcTmpArray removeObjectAtIndex:index];
    }
    return resultArray;
}

@end
