//
//  HomeViewCntrl.h
//  WXState
//
//  Created by digi on 31/12/13.
//  Copyright (c) 2013 TechnoPote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLHandler.h"
@interface HomeViewCntrl : UIViewController<XMLHandlerDelegate>
{
    XMLHandler *_xmlHandler;
    NSArray *stateAr;
    
}
@property (nonatomic, strong) IBOutlet UIImageView *mapImage;

-(void)loadMap:(NSString *)region;
@end
