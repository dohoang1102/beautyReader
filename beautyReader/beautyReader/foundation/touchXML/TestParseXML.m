//
//  TestParseXML.m
//  MBank
//
//  Created by zhu zhanping on 11-10-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "TestParseXML.h"

@implementation TestParseXML

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)test {
    // we will put parsed data in an a array
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    // using local resource file
    NSString *XMLPath = [[[NSBundle mainBundle] resourcePath]          stringByAppendingPathComponent:@"piglets.xml"];
    NSData *XMLData = [NSData dataWithContentsOfFile:XMLPath];
    CXMLDocument *doc = [[[CXMLDocument alloc] initWithData:XMLData options:0 error:nil] autorelease];
    
    NSArray *nodes = NULL;
    // searching for piglet nodes
    nodes = [doc nodesForXPath:@"//user" error:nil];
    
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        int counter;
        for(counter = 0; counter < [node childCount]; counter++) {
            // common procedure: dictionary with keys/values from XML node
            [item setObject:[[node childAtIndex:counter] stringValue] forKey:[[node childAtIndex:counter] name]];
        }
        
        // and here it is – attributeForName! Simple as that.
       // [item setObject:[[node attributeForName:@"id"] stringValue] forKey:@"id"];
        
        // <—— this magical arrow is pointing to the area of interest
        
        [res addObject:item];
        [item release];
    }
    
    // and we print our results
    DBLog(@"%@", res);
    [res release];
}
@end
