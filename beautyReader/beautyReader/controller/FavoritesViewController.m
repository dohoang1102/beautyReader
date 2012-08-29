//
//  FavoritesViewController.m
//  beautyReader
//
//  Created by superjoo on 8/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FavoritesView.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

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
    navBarTintColor = [self.navigationController.navigationBar.tintColor copy];
	self.view.frame = [UIApplication sharedApplication].keyWindow.frame;
    FavoritesView *view = [[[FavoritesView alloc] initWithFrame:self.view.frame] autorelease];
    view.controller = self;
    self.view = view;
    self.title = @"我的收藏";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) setSkin {
    FileUtils *fileUtil = [FileUtils sharedFileUtils];
    NSString *skin = [fileUtil getUserDefaultsForKey:Skin];
    if (skin == nil || (![skin isEqualToString:@"0"] && ![skin isEqualToString:@"1"])) {
        skin = @"0";
    }
    if ([skin isEqualToString:@"0"]) {//标准主题
        self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    } else {//小娇羞主题
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    }
}

-(void) viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.tintColor = navBarTintColor;
}

-(void) viewWillAppear:(BOOL)animated {
    //设置皮肤包
    [self setSkin];
}

-(void) dealloc {
    [navBarTintColor release];
    [super dealloc];
}

@end
