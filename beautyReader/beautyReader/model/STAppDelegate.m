//
//  STAppDelegate.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "STAppDelegate.h"
#import "MainViewController.h"
#import "CoreDataFactory.h"
#import "CHAPTER.h"

@implementation STAppDelegate

@synthesize window = _window;
@synthesize navigationController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    // Override point for customization after application launch.
    MainViewController *rootViewCtrl = [[[MainViewController alloc] init] autorelease];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewCtrl];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    FileUtils *fileUtil = [FileUtils sharedFileUtils];
    //首次加载
    NSString *firstVisit = [fileUtil getUserDefaultsForKey:FIRST_INSTALL];
    if (![@"1" isEqualToString:firstVisit]) {//first open app
        //数据库文件移动到DOCUMENTS文件夹
        NSError *error;
        NSString *filePath = [fileUtil getAppFilePath:@"sql" suffix:@"sqlite"];
        NSString *documentPath = [fileUtil getFilePath:@"sql.sqlite"];
        NSLog(@"%@",documentPath);
        if ([[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
            [[NSFileManager defaultManager] removeItemAtURL:[NSURL fileURLWithPath:documentPath] error:&error];
        }
        BOOL moveFlag;
        moveFlag = [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:documentPath error:&error];
        if(moveFlag) {
            [fileUtil setUserDefaults:@"1" key:FIRST_INSTALL];
            DBLog(@"---> %@",@"数据库文件初始化成功!");
        }
        //设置皮肤
        NSString *defaultSkin = NSLocalizedStringFromTable(@"defaultSkin", @"Configuration", @"0");
        [fileUtil setUserDefaults:defaultSkin key:Skin];
    }
    /*
    //测试文件查询
    CoreDataFactory *factory = [CoreDataFactory sharedInstance];
    NSManagedObjectContext *context = [factory managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] initWithEntityName:@"CHAPTER"] autorelease];
    NSError *err = nil;
    NSArray *retArra = [context executeFetchRequest:request error:&err];
    if (err!=nil) {
        NSLog(@"%@",err);
    }
    for (CHAPTER *chapter in retArra) {
        NSString *str = [[NSString alloc] initWithData:chapter.chapterEnZh encoding:NSUTF8StringEncoding];
        DBLog(@"...... %@",str);
    }
     */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
