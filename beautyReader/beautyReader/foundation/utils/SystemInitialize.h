//
//  SystemInitialize.h
//  beautyReader
//
//  Created by superjoo on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInitialize : NSObject

//初始化
-(BOOL) initialize;

//解析配置文件
-(BOOL) parseChapters:(NSString*)chapterFileUrl;

@end
