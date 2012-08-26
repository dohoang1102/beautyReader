//
//  SubjectService.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SubjectService.h"
#import "CoreDataFactory.h"
#import "SUBJECT.h"

@implementation SubjectService

-(NSArray*) querySubjectByType:(int) subjectType {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"SUBJECT"] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subjectType=%d",subjectType];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sequence" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSError *error = nil;
    NSArray *subjectArray = [context executeFetchRequest:request error:&error];
    if (error) {
        ELog(@"query subject error:subjectType:%d  errorInfo:%@",subjectType,[error localizedDescription]);
    }
    return subjectArray;
}


@end
