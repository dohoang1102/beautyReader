//
//  XMLParseFactory.h
//  MBank
//
//  Created by zhu zhanping on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"

@interface XMLParseFactory : NSObject {
@private
    CXMLDocument *document;//xml解析对象
@public
    NSData *xmlData;//xml解析对象
    NSString *parse_XPath;//解析节点名称
    NSMutableArray *parseArray;//解析
    NSStringEncoding encoding;//字符编码,默认utf-８
}

@property (nonatomic,retain) NSData *xmlData;
@property (nonatomic,retain) NSString *parse_XPath;
@property (nonatomic,retain) NSMutableArray *parseArray;
@property NSStringEncoding encoding;

-(id) initWithData:(NSData*) data;

-(NSArray *)parseXML;

-(NSArray *)parseBook;

-(NSArray *)parseXMLOfString:(NSString *)xml;

-(NSArray *)parseXMLOfString:(NSString *)xml withXPath:(NSString*)xPath;

-(NSArray *)parseXMLOfData:(NSData *)data;

-(NSArray *)parseXMLOfData:(NSData *)data withXPath:(NSString*)xPath;

-(NSDictionary *)parseWithElement:(CXMLElement*)element;
-(void) test;
@end
