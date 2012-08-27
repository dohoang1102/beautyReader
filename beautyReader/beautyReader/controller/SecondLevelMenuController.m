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
}

-(void) showFavorite {
    
}

-(void) dealloc {
    [dataSourceArray release];
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
    ReadViewController *readViewCtrl = [[ReadViewController alloc] init];
    readViewCtrl.subjectType = self.subjectType;
    readViewCtrl.chapter = [self.dataSourceArray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:readViewCtrl animated:YES];
    [readViewCtrl release];
}

@end
