//
//  SecondLevelMenuController.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondLevelMenuController.h"
#import "SecondLevelMenuView.h"
#import "SecondLevelMenuCell.h"
#import "ReadViewController.h"
#import "FavoritesViewController.h"
#import "CHAPTER.h"
#import "ChapterService.h"

@interface SecondLevelMenuController ()

@end

@implementation SecondLevelMenuController

@synthesize dataSourceArray,subjectType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	switch (subjectType) {
        case 1:
            self.title = @"春眠不觉晓";
            break;
        case 2:
            self.title = @"夏夜识花香";
            break;
        case 3:
            self.title = @"秋风觉人醒";
            break;
        case 4:
            self.title = @"冬日独思量";
            break;
        default:
            break;
    }
	SecondLevelMenuView *secondView = [[[SecondLevelMenuView alloc] initWithFrame:self.view.frame delegate:self] autorelease];
    self.view = secondView;
    //收藏夹
    UIBarButtonItem *rightItem = [[[UIBarButtonItem alloc] initWithTitle:@"收藏夹" style:UIBarButtonItemStylePlain target:self action:@selector(showFavorite)] autorelease];
    self.navigationItem.rightBarButtonItem = rightItem;
    //注册IAP事件监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductIdError:) name:kInAppPurchaseManagerProductsFetchedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseSuccess:) name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseFail:) name:kInAppPurchaseManagerTransactionFailedNotification object:nil];
}

-(void) showFavorite {
    FavoritesViewController *favoritesController = [[FavoritesViewController alloc] init];
    [self.navigationController pushViewController:favoritesController animated:YES];
    [favoritesController release];
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kInAppPurchaseManagerProductsFetchedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kInAppPurchaseManagerTransactionFailedNotification object:nil];
    [dataSourceArray release];
    [HUD release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"secondLevel";
    SecondLevelMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[SecondLevelMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell resizeCell:[self.dataSourceArray objectAtIndex:[indexPath row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (dataSourceArray && [dataSourceArray count] > 0) {
        SecondLevelMenuCell *cell = (SecondLevelMenuCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cell cellHeight];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CHAPTER *selectChapter = [self.dataSourceArray objectAtIndex:[indexPath row]];
    if (![selectChapter.free boolValue]) {//收费应用
        //[self inAppPurchWithCellIndex:[indexPath row]];
        [HUD release];
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.animationType = MBProgressHUDAnimationZoom;
        HUD.delegate = self;
        HUD.labelText = @"加载中";
        //[HUD showWhileExecuting:@selector(inAppPurchWithCellIndex:) onTarget:self withObject:[NSNumber numberWithInt:[indexPath row]] animated:YES];
        [self inAppPurchWithCellIndex:[NSNumber numberWithInt:[indexPath row]]];
        [HUD show:YES];
    } else {
        ReadViewController *readViewCtrl = [[ReadViewController alloc] init];
        readViewCtrl.subjectType = self.subjectType;
        readViewCtrl.chapter = selectChapter;
        [self.navigationController pushViewController:readViewCtrl animated:YES];
        [readViewCtrl release];
    }
}

//IAP付费
-(void) inAppPurchWithCellIndex:(NSNumber*)index{
    if (!inAppPurchase) {
        inAppPurchase = [[InAppPurchaseManager alloc] init];
    }
    inAppPurchase.productId = @"com.beautyReader.productTest1";
    inAppPurchase.inAppPurchaseIndex = [index intValue];
    inAppPurchase.HUD = HUD;
    [inAppPurchase loadStore];
}

#pragma mark - notification methods

//获取产品ID失败
-(void) getProductIdError:(NSNotification*)notivication {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统错误" message:@"无法购买专辑，请联系管理员" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [alert release];
}
//购买成功回调函数
-(void) purchaseSuccess:(NSNotification*)notivication {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    //更改数据库状态，并刷新视图
    NSDictionary *userInfo = notivication.userInfo;
    NSString *cellIndex = [userInfo objectForKey:@"index"];
    CHAPTER *purchChapter = [self.dataSourceArray objectAtIndex:[cellIndex intValue]];
    purchChapter.free = [NSNumber numberWithBool:YES];
    ChapterService *service = [[ChapterService alloc] init];
    [service updateChapter:purchChapter];
    [service release];
    SecondLevelMenuView *listView = (SecondLevelMenuView*)self.view;
    [listView reloadData];
}

//购买失败回调函数
-(void) purchaseFail:(NSNotification *)notivication {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统错误" message:@"购买专辑失败，请与管理员联系" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [alert release];
}


@end
