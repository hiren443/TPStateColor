//
//  MenuViewController.m
//  WXState
//
//  Created by digi on 31/12/13.
//  Copyright (c) 2013 TechnoPote. All rights reserved.
//

#import "MenuViewController.h"
#import "MFSideMenu.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    self.arMenu = [[NSMutableArray alloc] initWithObjects:@"Africa",@"Asia",@"Europe",@"Noam",@"Oceania",@"Soam", nil];
}
-(void)selectMenu:(NSString *)menu {
	int row = 0;
	int count = 0;
	for(NSString *mnu in self.arMenu) {
		if([mnu isEqualToString:menu]) {
			row = count;
			break;
		}
		count++;
	}
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
	[self.tblMenu selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	indexPath = nil;
}
#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
     cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
     }
     [cell setBackgroundColor:[UIColor clearColor]];
     cell.textLabel.textColor = [UIColor lightGrayColor];
     cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
     cell.textLabel.text = [self.arMenu objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *selected = [NSString stringWithFormat:@"%@", [self.arMenu objectAtIndex:indexPath.row]];
    [APP_DELEGATE selectMenu:selected];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
