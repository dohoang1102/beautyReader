//
//  SentenceViewController.m
//  beautyReader
//
//  Created by superjoo on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SentenceViewController.h"
#import "SentenceListView.h"
#import "CHAPTER.h"
#import "SENTENCE.h"
#import "FavoritesViewController.h"

@interface SentenceViewController ()

-(void) handleTapGesture:(UIGestureRecognizer*)gesture;

@end

@implementation SentenceViewController

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
    navBarTintColor = [self.navigationController.navigationBar.tintColor copy];
	self.view.frame = [UIApplication sharedApplication].keyWindow.frame;
    SentenceListView *sentenceView = [[SentenceListView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    sentenceView.delegate = sentenceView;
    sentenceView.dataSource = sentenceView;
    self.view = sentenceView;
    [sentenceView release];
    NSMutableArray *sentArr = [NSMutableArray array];
    for (SENTENCE *sentence in chapter.sentences) {
        [sentArr addObject:sentence];
    }
    sentenceView.sentenceListArray = sentArr;
    sentenceView.channel = FROM_READER;
    self.title = chapter.chapterName;
    
    //收藏夹
    UIBarButtonItem *rightItem = [[[UIBarButtonItem alloc] initWithTitle:@"收藏夹" style:UIBarButtonItemStylePlain target:self action:@selector(showFavorite)] autorelease];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    [tapGesture release];
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

-(void) handleTapGesture:(UIGestureRecognizer*)gesture {
    if (isFullScreen) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    isFullScreen = !isFullScreen;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([[touch view] isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

-(void) showFavorite {
    FavoritesViewController *favoritesController = [[FavoritesViewController alloc] init];
    [self.navigationController pushViewController:favoritesController animated:YES];
    [favoritesController release];
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
