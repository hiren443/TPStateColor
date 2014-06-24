//
//  TPMapController.h
//  WXState
//
//  Created by digi on 10/01/14.
//  Copyright (c) 2014 TechnoPote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLHandler.h"

@interface TPMapController : UIViewController <MKMapViewDelegate,XMLHandlerDelegate>
{
    XMLHandler *_xmlHandler;
    NSArray *stateAr;

}

-(void)loadMap:(NSString *)region;
- (void)loadPinOnMap;

@end
