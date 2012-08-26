//
//  MainViewController.m
//  beautyReader
//
//  Created by zhu zhanping on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "FirstLevelMenuController.h"
#import "SubjectService.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    MainView *mainView = [[[MainView alloc] initWithFrame:self.view.frame] autorelease];
    mainView.controller = self;
    self.view = mainView;
}

-(void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
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

//进入一级菜单
-(void) showFiestLevelMenu:(int) subjectType {
    //查询一级菜单内容
    SubjectService *service = [[[SubjectService alloc] init] autorelease];
    FirstLevelMenuController *firstLevelCtrl = [[FirstLevelMenuController alloc] init];
    firstLevelCtrl.subjectType = subjectType;
    firstLevelCtrl.dataSourceArray = [service querySubjectByType:subjectType];
    [self.navigationController pushViewController:firstLevelCtrl animated:YES];
    [firstLevelCtrl release];
}

@end
