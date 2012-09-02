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
#import "GAME.h"

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

-(BOOL) updateChapter:(CHAPTER*)chapter {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSError *error = nil;
    return [context save:&error];
}

-(CHAPTER*) queryChapterWithId:(int) chapterId {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"CHAPTER"] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chapterId=%d",chapterId];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *chapterArray = [context executeFetchRequest:request error:&error];
    if (error) {
        ELog(@"query chapter list error:chapterId:%d  errorInfo:%@",chapterId,[error localizedDescription]);
        return nil;
    }
    if ([chapterArray count] > 0) {
        return [chapterArray objectAtIndex:0];
    }
    return nil;
}

-(BOOL) updateGameScore:(NSNumber*)chapterId level:(int)level time:(int)gameTimes score:(int) score {
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"GAME"] autorelease];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(chapterId=%d) AND (level=%d)",[chapterId intValue],level];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *gameArray = [context executeFetchRequest:request error:&error];
    if (error) {
        ELog(@"query game list error:chapterId:%d  errorInfo:%@",[chapterId intValue],[error localizedDescription]);
        return NO;
    }
    if ([gameArray count] > 0) {//有数据，更新
        GAME *game = [gameArray objectAtIndex:0];
        if ([game.score intValue] < score) {
            game.score = [NSNumber numberWithInt:score];
        }
        if ([game.time intValue] > gameTimes) {
            game.time = [NSNumber numberWithInt:gameTimes];
        }
        return ([context save:&error]);
    }else {//无数据，插入
        CoreDataFactory *factory = [CoreDataFactory sharedInstance];
        NSManagedObjectContext *context = [factory managedObjectContext];
        NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"CHAPTER"] autorelease];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"chapterId=%d",[chapterId intValue]];
        [request setPredicate:predicate];
        NSError *error = nil;
        NSArray *chapterArray = [context executeFetchRequest:request error:&error];
        if (error) {
            ELog(@"query chapter list error:chapterId:%d  errorInfo:%@",[chapterId intValue],[error localizedDescription]);
            return NO;
        }
        if (!chapterArray || [chapterArray count] == 0) {
            return NO;
        }
        CHAPTER *chapter = [chapterArray objectAtIndex:0];
        GAME *game = (GAME*)[NSEntityDescription insertNewObjectForEntityForName:@"GAME" inManagedObjectContext:context];
        game.chapterId = chapterId;
        game.level = [NSNumber numberWithInt:level];
        game.score = [NSNumber numberWithInt:score];
        game.time = [NSNumber numberWithInt:gameTimes];
        NSMutableSet *gameSet = [NSMutableSet setWithSet:chapter.games];
        [gameSet addObject:game];
        chapter.games = gameSet;
        return ([context save:&error]);
    }
}

@end
