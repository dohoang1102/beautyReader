//
//  XMLParseFactory.m
//  MBank
//
//  Created by zhu zhanping on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XMLParseFactory.h"

@implementation XMLParseFactory

@synthesize xmlData,parseArray,parse_XPath,encoding;

- (id)init
{
    self = [super init];
    if (self) {
        encoding = NSUTF8StringEncoding;
        parseArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(id) initWithData:(NSData*) data {
    if (self = [self init]) {
        self.xmlData = data;
    }
    return self;
}

-(NSArray *)parseXML {
    return [self parseXMLOfData:self.xmlData];
}

-(NSArray *)parseXMLOfString:(NSString *)xml {
    if (!xml) {
        return nil;
    }
    self.xmlData = [xml dataUsingEncoding:encoding];
    return [self parseXMLOfData:self.xmlData];
}

-(NSArray *)parseBook {
    NSError *error = nil;
    document = [[CXMLDocument alloc] initWithData:self.xmlData options:1 error:&error];
    CXMLElement *root = [document rootElement];
    if (error) {
        DBLog(@"parse book error:%@",[error localizedDescription]);
        return nil;
    }
    for (CXMLElement *element in [root children]) {
        NSMutableDictionary *oneValue = [NSMutableDictionary dictionary];
        if ([@"text" isEqualToString:[element name]]) {
            continue;
        }
        //parse book
        for (CXMLElement *bookSubElement in [element children]) {
            if ([@"text" isEqualToString:[bookSubElement name]]) {
                continue;
            }
            if (![@"sections" isEqualToString:[bookSubElement name]]) {
                [oneValue setObject:[bookSubElement stringValue] forKey:[bookSubElement name]];
            } else {
                NSMutableArray *sectionArray = [NSMutableArray array];
                for (CXMLElement *sectionSubElement in [bookSubElement children]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    if ([@"text" isEqualToString:[sectionSubElement name]]) {
                        continue;
                    }
                    for (CXMLElement *leafElement in [sectionSubElement children]) {
                        if ([@"text" isEqualToString:[leafElement name]]) {
                            continue;
                        }
                        [dic setObject:[leafElement stringValue] forKey:[leafElement name]];
                    }
                    [sectionArray addObject:dic];
                }
                [oneValue setObject:sectionArray forKey:@"sections"];
            }
        }
        [self.parseArray addObject:[NSMutableDictionary dictionaryWithObject:oneValue forKey:[element name]]];
    }
    return self.parseArray;
}

-(NSArray *)parseXMLOfData:(NSData *)data {
    NSError *error;
    document = [[CXMLDocument alloc] initWithData:data encoding:encoding options:1 error:&error];
    CXMLElement *root= [document rootElement];
    if (error) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"9999" forKey:@"errCode"];
        [dic setObject:[error localizedDescription] forKey:@"errValue"];
        [self.parseArray addObject:dic];
        return self.parseArray;
    }
    for (CXMLElement *element in [root children]) {
        NSDictionary *tmp = [self parseWithElement:element];
        if (tmp) {
            [parseArray addObject:tmp];
        }
    }
    return self.parseArray;
}

-(NSDictionary *)parseWithElement:(CXMLElement*)element {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSString *name = [element name];
    NSObject *value = nil;
    if ([name isEqualToString:@"text"]) {
        return nil;
    }
    if ([element childCount] <= 1) {
        value = [element stringValue];
        [dictionary setObject:value forKey:name];
        return dictionary;
    } else {
        NSMutableDictionary *dics = [NSMutableDictionary dictionary];
        for (CXMLElement *elem in [element children]) {
            [dics setValuesForKeysWithDictionary:[self parseWithElement:elem]];
        }
        [dictionary setObject:dics forKey:[element name]];
    }
    return dictionary;
}

-(NSArray *)parseXMLOfData:(NSData *)data withXPath:(NSString*)xPath {
    NSError *error;
    document = [[CXMLDocument alloc] initWithData:data encoding:encoding options:1 error:&error];
    NSArray *elements= [document nodesForXPath:[NSString stringWithFormat:@"//%@",xPath] error:&error];
    if (error) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"9999" forKey:@"ec"];
        [dic setObject:[error localizedDescription] forKey:@"em"];
        [self.parseArray addObject:dic];
        return self.parseArray;
    }
    for (CXMLElement *element in elements) {
        NSDictionary *tmp = [self parseWithElement:element];
        if (tmp) {
            [parseArray addObject:tmp];
        }
    }
    return parseArray;
}

-(NSArray *)parseXMLOfString:(NSString *)xml withXPath:(NSString*)xPath {
    if (!xml) {
        return nil;
    }
    self.xmlData = [xml dataUsingEncoding:encoding];
    return [self parseXMLOfData:xmlData withXPath:xPath];    
}

-(void)dealloc {
    [document release];
    [xmlData release];
    [parseArray release];
    [parse_XPath release];
    [super dealloc];
}

-(void) test {
    NSString *xml  = @"<users><user><id>CN0001</id><name>张三</name><gender>01</gender><age>23</age></user><user><id>CN0002</id><name>张三</name><gender>02</gender><age>22</age></user><user><id>CN0003</id><name>张三</name><gender>02</gender><age>25</age></user><user><id>CN0004</id><name>张三</name><gender>01</gender><age><age1>11</age1><age2>22</age2></age></user></users>";
    [self parseXMLOfString:xml];
    //[self parseXMLOfString:xml withXPath:@"age"];
}

@end
