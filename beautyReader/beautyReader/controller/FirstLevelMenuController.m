//
//  FirstLevelMenuController.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FirstLevelMenuController.h"
#import "FirstLevelMenuView.h"
#import "FirstLevelMenuCell.h"
#import "ChapterService.h"
#import "SecondLevelMenuController.h"
#import "FavoritesViewController.h"

@interface FirstLevelMenuController ()

@end

@implementation FirstLevelMenuController

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
	FirstLevelMenuView *firstView = [[[FirstLevelMenuView alloc] initWithFrame:self.view.frame delegate:self] autorelease];
    self.view = firstView;
    //收藏夹
    UIBarButtonItem *rightItem = [[[UIBarButtonItem alloc] initWithTitle:@"收藏夹" style:UIBarButtonItemStylePlain target:self action:@selector(showFavorite)] autorelease];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void) showFavorite {
    FavoritesViewController *favoritesController = [[FavoritesViewController alloc] init];
    [self.navigationController pushViewController:favoritesController animated:YES];
    [favoritesController release];
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

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) dealloc {
    [dataSourceArray release];
    [super dealloc];
}

#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"firstLevel";
    FirstLevelMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[FirstLevelMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    [cell resizeCell:[self.dataSourceArray objectAtIndex:[indexPath row]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChapterService *service = [[[ChapterService alloc] init] autorelease];
    NSArray *chapterList = [service queryChaptersWithSubject:[self.dataSourceArray objectAtIndex:[indexPath row]]];
    SecondLevelMenuController *secondCtrl = [[[SecondLevelMenuController alloc] init] autorelease];
    secondCtrl.dataSourceArray = chapterList;
    secondCtrl.subjectType = self.subjectType;
    [self.navigationController pushViewController:secondCtrl animated:YES];
}

@end
