//
//  XMLCreateFactory.m
//  MBank
//
//  Created by zhu zhanping on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XMLCreateFactory.h"

@implementation XMLCreateFactory

@synthesize xmlDictonary;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(id) initWithDictionary:(NSDictionary *)dictionary {
    if (self = [self init]) {
        self.xmlDictonary = dictionary;
    }
    return self;
}

//判断节点是否是叶子节点
-(BOOL) isLeaf:(NSDictionary*)dic {
    return [dic count]==1&&[[[dic allValues] objectAtIndex:0] isKindOfClass:[NSString class]];
}

-(CXMLDocument*)newDocument {
    return [self createDocument:xmlDictonary];
}

-(CXMLNode*)createNode:(NSDictionary*)dic {
    NSString *name = [[dic allKeys] objectAtIndex:0];
    NSString *value = [dic objectForKey:name];
    CXMLNode *node = [CXMLNode elementWithName:name stringValue:value];
    return node;
}

-(CXMLElement*)createElement:(NSDictionary*)dic {
    NSString *name = [[dic allKeys] objectAtIndex:0];
    id value = [dic objectForKey:name];
    CXMLElement *element = [CXMLElement elementWithName:name];
   /*
    if ([value isKindOfClass:[NSString class]]) {
        element.stringValue = (NSString*)value;
        return element;
    }
    if ([self isLeaf:value]) {
        [element addChild:[self createNode:value]];
        return element;
    }*/
    for (id el in value) {
        if ([el isKindOfClass:[NSString class]]) {
            NSDictionary *tmp = [NSDictionary dictionaryWithObject:[value objectForKey:el] forKey:el];
            if ([[value objectForKey:el] isKindOfClass:[NSString class]]) {
                [element addChild:[self createNode:tmp]];
            } else {
                [element addChild:[self createElement:tmp]];
            }
        }else if ([self isLeaf:el]) {
            [element addChild:[self createNode:el]];
        } else {
            [element addChild:[self createElement:el]];
        }
    }
    return element;
}

-(CXMLDocument*)createDocument:(NSDictionary*)dic {
    document = [CXMLNode document];
    for (NSString *key in [dic allKeys]) {
        id value = [dic objectForKey:key];
        NSDictionary *element = [NSDictionary dictionaryWithObject:value forKey:key];
        if ([self isLeaf:element]) {// 当前节点为叶子节点
            CXMLNode *node = [self createNode:element];
            [document addChild:node];
        } else {// 当前节点含有子节点
            CXMLElement *el = [self createElement:element];
            [document addChild:el];
        }
    }
    return document;
}

-(NSString*) stringValue {
    return  [[[NSString alloc] initWithData:[document XMLData] encoding:NSUTF8StringEncoding] autorelease];
}

-(void)test {
    /*
    NSMutableDictionary *root =[NSMutableDictionary dictionary]; 
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"123" forKey:@"name"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"11" forKey:@"age1"];
    [dic2 setObject:@"22" forKey:@"age2"];
    [dic setObject:dic2 forKey:@"age"];
    [root setObject:dic forKey:@"root"];
    self.xmlDictonary = dic2;
    [self newDocument];
    NSString *str = [[NSString alloc] initWithData:[document XMLData] encoding:NSUTF8StringEncoding];
    DBLog(@"====== %@",str);
     */
}

-(void) dealloc {
    [document release];
    [xmlDictonary release];
    [super dealloc];
}

@end
