//
//  SUBJECT.h
//  beautyReader
//
//  Created by superjoo on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SUBJECT : NSManagedObject

@property (nonatomic, retain) NSString * subjectName;//一级菜单标题
@property (nonatomic, retain) NSString * subjectTranslation;//一级菜单标题翻译
@property (nonatomic, retain) NSString * subjectInfo;//一级菜单详细信息
@property (nonatomic, retain) NSNumber * sequence;//排序字段

@end
