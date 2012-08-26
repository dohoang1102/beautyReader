//
//  SUBJECT.h
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SUBJECT : NSManagedObject

@property (nonatomic, retain) NSNumber * sequence;//序列号
@property (nonatomic, retain) NSString * subjectInfo;//说明
@property (nonatomic, retain) NSString * subjectName;//一级菜单名称
@property (nonatomic, retain) NSString * subjectTranslation;//备注
@property (nonatomic, retain) NSNumber * subjectType;//菜单类别: 1、春　２、夏　３、秋　４、冬

@end
