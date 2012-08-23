//
//  beautyReaderTests.m
//  beautyReaderTests
//
//  Created by zhu zhanping on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "beautyReaderTests.h"
#import "SystemInitialize.h"

@implementation beautyReaderTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in beautyReaderTests");
}

//该测试用例用来提前生成数据库文件,由于初始化较慢，将初始化文件在打包前提前做好，
//并添加到系统目录中，首次初始化时，将文件拷贝到documents下面,减少启动时间
-(void) testInitData{
    SystemInitialize *initial = [[[SystemInitialize alloc] init] autorelease];
    [initial initialize];
}

@end
