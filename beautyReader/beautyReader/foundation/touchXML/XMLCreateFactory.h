//
//  XMLCreateFactory.h
//  MBank
//
//  Created by zhu zhanping on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"

@interface XMLCreateFactory : NSObject {
@private
    CXMLDocument *document;//xml对象
@public
    NSDictionary *xmlDictonary;//组装对象数组
}

@property (nonatomic,retain) NSDictionary *xmlDictonary;

-(id) initWithDictionary:(NSDictionary *)dictionary;

-(CXMLDocument*)newDocument;

-(CXMLNode*)createNode:(NSDictionary*)dic;

-(CXMLElement*)createElement:(NSDictionary*)dic;

-(CXMLDocument*)createDocument:(NSDictionary*)dic;

-(NSString*) stringValue;

-(BOOL) isLeaf:(NSDictionary*)dic;//是否是叶子节点

-(void)test;
@end
