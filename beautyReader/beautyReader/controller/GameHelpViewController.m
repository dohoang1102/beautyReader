//
//  GameHelpViewController.m
//  beautyReader
//
//  Created by superjoo on 8/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameHelpViewController.h"
#import "GameHelperView.h"

@interface GameHelpViewController ()

@end

@implementation GameHelpViewController

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
	[super viewDidLoad];
    CGRect bounds = [UIApplication sharedApplication].keyWindow.frame;
    self.view.frame = bounds;
    
    GameHelperView *gameHelper = [[GameHelperView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.height, bounds.size.width-20)];
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
 /*
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
    CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    self.navigationController.view.transform = CGAffineTransformMakeRotation(0);
    self.navigationController.view.bounds = [UIApplication sharedApplication].keyWindow.frame;  
    [UIView commitAnimations];  
  */
    [self.navigationController popViewControllerAnimated:YES];
}

@end
