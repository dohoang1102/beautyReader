//
//  ChapterService.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChapterService.h"
#import "SUBJECT.h"
#import "CHAPTER.h"
#import "WORD.h"
#import "CoreDataFactory.h"
#import "SENTENCE.h"

@implementation ChapterService

-(NSArray*) queryChaptersWithSubject:(SUBJECT*)subject {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"CHAPTER"] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subject=%@",subject.subjectTranslation];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"sequence" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSError *error = nil;
    NSArray *chapterArray = [context executeFetchRequest:request error:&error];
    if (error) {
        ELog(@"query chapter list error:subject:%@  errorInfo:%@",subject.subjectTranslation,[error localizedDescription]);
    }
    return chapterArray;
}

-(NSArray*) queryWordsWithChapter:(CHAPTER*)chapter {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"WORD"] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chapterId=%d",[chapter.chapterId intValue]];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"wordId" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSError *error = nil;
    NSArray *wordsArray = [context executeFetchRequest:request error:&error];
    if (error) {
        ELog(@"query word list error:chapter:%d errorInfo:%@",[chapter.chapterId intValue],[error localizedDescription]);
    }
    return wordsArray;
}

-(NSArray*) queryFavoritesWords {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"WORD"] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"majorWord=1"];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"opTime" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSError *error = nil;
    NSArray *wordsArray = [context executeFetchRequest:request error:&error];
    if (error) {
        ELog(@"query favor word list error, errorInfo:%@",[error localizedDescription]);
    }
    return wordsArray;
}

-(NSArray*) queryFavoritesSentences {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"SENTENCE"] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"majorSentence=1"];
    [request setPredicate:predicate];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"opTime" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    NSError *error = nil;
    NSArray *sentenceArray = [context executeFetchRequest:request error:&error];
    if (error) {
        ELog(@"query sentence list error, errorInfo:%@",[error localizedDescription]);
    }
    return sentenceArray;
}

-(BOOL) updateWords:(WORD*)word {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSError *error = nil;
    return [context save:&error];
}

-(BOOL) updateSentence:(SENTENCE*)sentence {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSError *error = nil;
    return [context save:&error];
}

@end
