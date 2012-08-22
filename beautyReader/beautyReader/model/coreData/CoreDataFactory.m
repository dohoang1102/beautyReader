//
//  CoreDataFactory.m
//  CoreDataDemo
//
//  Created by superjoo on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataFactory.h"

static CoreDataFactory *_coreDataFactory;
@implementation CoreDataFactory

//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark siglon methods

+(id) allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (!_coreDataFactory) {//when the first time you call alloc method,return an object else return nil
            _coreDataFactory = [super allocWithZone:zone];
            return _coreDataFactory;
        }
    }
    return nil;
}

+(id) copyWithZone:(NSZone *)zone {
    return self;
}

-(id) retain {
    return self;
}

-(NSUInteger) retainCount {
    return NSUIntegerMax;
}

/*oneway 用在分布式对象的API，这些API可以是不同的线程，甚至是不同的程序，oneway之用在返回类型为void的消息定义中，因为oneway是异步的，其消息预计不会立即返回,oneway表示线程之间通讯的接口定义，表示单向的调用*/
//-(oneway void) release {}

-(id) autorelease {
    return self;
}

+(CoreDataFactory*)sharedInstance {
    if (!_coreDataFactory) {
        @synchronized(self) {
            if (!_coreDataFactory) {
                _coreDataFactory = [[CoreDataFactory alloc] init];
            }
        }
    }
    return _coreDataFactory;
}


#pragma mark - coreData methods
-(void) saveContext {
    NSError *error = nil;
    if (self.managedObjectContext) {
        // when you save error you can use abort() method termibate the app and generate a crash log
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
            DBLog(@"unresoved error %@,%@",error,[error userInfo]);
            //abort();
        }
    }
}

-(NSManagedObjectContext*)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        _managedObjectContext.persistentStoreCoordinator = coordinator;
    }
    return _managedObjectContext;
}

-(NSManagedObjectModel*) managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    //获取datamodel资源 即coreData.xcdatamodeld 但后缀名要用momd
    /*
   NSURL *modelUrl = [[NSBundle mainBundle] URLForResource:@"coreData" withExtension:@"momd"];
    if (!modelUrl) {
        modelUrl = [[NSBundle mainBundle] URLForResource:@"coreData" withExtension:@"mom"];
    }
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelUrl];
     */
    //另外一种获取模型的方式 获取bundle里面最后一个数据模型
    _managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    return _managedObjectModel;
}

-(NSPersistentStoreCoordinator*)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    //指定数据库名字以及存储路径，可以随便明名，与数据模型无关
    NSURL *sandBoxUrl = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *sqliteURL = [sandBoxUrl URLByAppendingPathComponent:DATABASE_NAME];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteURL options:nil error:&error]) {
        DBLog(@"unresoved error %@,%@",error,[error userInfo]);
        //abort();
    }
    return _persistentStoreCoordinator;
}

-(void) dealloc {
    [_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    [super dealloc];
}


@end
