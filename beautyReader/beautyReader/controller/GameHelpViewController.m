//
//  GameHelpViewController.m
//  beautyReader
//
//  Created by superjoo on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameHelpViewController.h"
#import "GameHelperView.h"
#import "GameLevelViewController.h"

@interface GameHelpViewController ()

@end

@implementation GameHelpViewController

@synthesize chapter;

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
    CGRect bounds = [UIApplication sharedApplication].keyWindow.frame;
    self.view.frame = bounds;
    
    GameHelperView *gameHelper = [[GameHelperView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width)];
    gameHelper.controller = self;
    self.view = gameHelper;
    [gameHelper release];
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

-(void) goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) showGameLevel {
    GameLevelViewController *gameLevel = [[GameLevelViewController alloc] init];
    gameLevel.chapter = chapter;
    [self.navigationController pushViewController:gameLevel animated:YES];
    [gameLevel release];
}

@end
