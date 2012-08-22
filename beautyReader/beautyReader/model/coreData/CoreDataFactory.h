//
//  CoreDataFactory.h
//  CoreDataDemo
//  this class can create a singleton coredata operation factory
//
//  1. create a managedObjectModel
//  2. create a persistentStoreCoordinator with managedObjectModel
//  3. create namagedObjectContext with persistentStoreCoordinator
//
//  Created by superjoo on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataFactory : NSObject {
    NSManagedObjectContext *_managedObjectContext;// the data operation context
    NSManagedObjectModel *_managedObjectModel;// the model persistance of coreData
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;//
}

@property (nonatomic,readonly,getter = managedObjectContext) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/*get an singlon instance of coreDataFactory*/
+(CoreDataFactory*)sharedInstance;

/* save the context if context changed*/
-(void) saveContext;

@end
