//
//  GameMenuViewController.m
//  beautyReader
//
//  Created by superjoo on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameMenuViewController.h"
#import "CHAPTER.h"
#import "GameMenuView.h"
#import "GameHelpViewController.h"
#import "GameLevelViewController.h"

@interface GameMenuViewController ()

@end

@implementation GameMenuViewController

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
    
    GameMenuView *gameMenu = [[GameMenuView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width - 20)];
    gameMenu.controller = self;
    self.view = gameMenu;
    [gameMenu release];
	
    [[UIApplication sharedApplication] setStatusBarOrientation: UIInterfaceOrientationLandscapeRight animated: YES];  
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;  
    [UIView beginAnimations:nil context:nil];  
    [UIView setAnimationDuration:duration];  
    self.navigationController.view.transform = CGAffineTransformIdentity;  
    self.navigationController.view.transform = CGAffineTransformMakeRotation(M_PI*(90)/180.0);  
    self.navigationController.view.bounds = CGRectMake(0, 0, 480, 320);  
    [UIView commitAnimations];  
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

-(void) goBack {
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    self.navigationController.view.transform = CGAffineTransformMakeRotation(0);
    self.navigationController.view.bounds = [UIApplication sharedApplication].keyWindow.frame;  
    [UIView commitAnimations];  
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) showHelpInfo {
    GameHelpViewController *gameHelper = [[GameHelpViewController alloc] init];
    gameHelper.chapter = chapter;
    [self.navigationController pushViewController:gameHelper animated:YES];
    [gameHelper release];
}

-(void) showGameLevel {
    GameLevelViewController *gameLevel = [[GameLevelViewController alloc] init];
    gameLevel.chapter = chapter;
    [self.navigationController pushViewController:gameLevel animated:YES];
    [gameLevel release];
}

-(void) dealloc {
    [chapter release];
    [super dealloc];
}

@end
