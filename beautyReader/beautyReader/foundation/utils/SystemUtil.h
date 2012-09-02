//
//  SystemUtil.h
//  beautyReader
//
//  Created by zhu zhanping on 12-9-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemUtil : NSObject

//获取数组中的随机因子子数组
+(NSArray*)randomArray:(NSArray*)srcArray randomFactor:(int) factor;

@end
