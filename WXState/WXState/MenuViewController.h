//
//  MenuViewController.h
//  WXState
//
//  Created by digi on 31/12/13.
//  Copyright (c) 2013 TechnoPote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    
}
@property(strong, nonatomic) IBOutlet UITableView *tblMenu;

@property(strong, nonatomic) NSMutableArray *arMenu;
-(void) selectMenu:(NSString*)menu;
-(void) refreshCartCount;

@end
