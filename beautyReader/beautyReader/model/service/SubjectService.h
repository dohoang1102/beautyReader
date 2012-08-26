//
//  SubjectService.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectService : NSObject

//根据书籍类型查询一级菜单主题列表
-(NSArray*) querySubjectByType:(int) subjectType;

@end
