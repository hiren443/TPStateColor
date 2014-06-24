//
//  HomeViewCntrl.m
//  WXState
//
//  Created by digi on 31/12/13.
//  Copyright (c) 2013 TechnoPote. All rights reserved.
//

#import "HomeViewCntrl.h"
#import "MFSideMenu.h"
#import "XMLHandler.h"

@interface HomeViewCntrl ()

@end

@implementation HomeViewCntrl

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
    [self setupMenuBarButtonItems];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:45.0/255.0 green:150.0/255.0 blue:184.0/255.0 alpha:1.0];
    
    _xmlHandler=[[XMLHandler alloc] init];
    _xmlHandler.delegate=self;
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"wxstat" ofType:@"xml"];
    [_xmlHandler parseXMLFileAt:xmlPath];


}

- (void)finishedParsing:(NSArray*)flightContent{
    stateAr =[[NSMutableArray alloc ] initWithArray:flightContent];
}

- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.navigationController.parentViewController;
}
#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
        self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setImage:[UIImage imageNamed:@"icon_menu.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
#pragma mark -
#pragma mark - UIBarButtonItem Callbacks


- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
}

-(void)loadMap:(NSString *)region{
    self.mapImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",region]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
