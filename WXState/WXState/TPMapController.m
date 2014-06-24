//
//  TPMapController.m
//  WXState
//
//  Created by digi on 10/01/14.
//  Copyright (c) 2014 TechnoPote. All rights reserved.
//

#import "TPMapController.h"
#import "MFSideMenu.h"
#import "XMLHandler.h"
#import "MyLocation.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "Annotation.h"
#import "CustomAnnotationView.h"



@interface TPMapController ()
@property (nonatomic, strong) IBOutlet MKMapView *stateMapView;
@end

@implementation TPMapController

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
    
    NSArray *overlays = [TPMapController usStatesAndTerritoryOverlays];
    [self.stateMapView addOverlays:overlays];
    
    UILongPressGestureRecognizer *dropPin = [[UILongPressGestureRecognizer alloc] init];
    [dropPin addTarget:self action:@selector(handleLongPress:)];
	dropPin.minimumPressDuration = 5;
	[self.stateMapView addGestureRecognizer:dropPin];


}
- (void)finishedParsing:(NSArray*)flightContent{
    stateAr =[[NSMutableArray alloc ] initWithArray:flightContent];
    [self loadPinOnMap];
}

- (void)loadPinOnMap{

    for (id<MKAnnotation> annotation in self.stateMapView.annotations) {
        [self.stateMapView removeAnnotation:annotation];
    }
    [self.stateMapView setNeedsDisplay];
    
    for (NSDictionary * row in stateAr) {
        float latitude = [[row objectForKey:@"lat"] floatValue];
        float longitude = [[row objectForKey:@"lng"] floatValue];
        
        NSString * route =[row objectForKey:@"name"];
        NSString *fltid = [row objectForKey:@"weather"];
        NSString * originDate = [NSString stringWithFormat:@"%@ %@",[row objectForKey:@"wind"],[row objectForKey:@"temperature"]];

        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude;
        coordinate.longitude = longitude;
        
        Annotation *ann = [[Annotation alloc] initWithLocation:coordinate];
        ann.title = route;
        ann.subtitle = fltid;
        ann.thirdtitle = originDate;
        ann.fourthtitle = route;
        [self.stateMapView addAnnotation:ann];
    }
    
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *identifier = @"CustomPinAnnotationView";
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[Annotation class]]) {
        CustomAnnotationView* annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        //        [annotationView removeFromSuperview];
        //        annotationView = nil;
        if (!annotationView	) {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
        } else {
            [annotationView removeImage];
            annotationView.annotation = annotation;
        }
        
        UIImage *img = [UIImage imageNamed:@"pinRed.png"];
/*        angle = ((Annotation*)annotation).angle;
        if(angle == 999){
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"planeRED.png"]];
        }
        else{
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:plainColor]];
            //            imageView.transform= CGAffineTransformMakeRotation(angle);
            imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(angle));
        }
        imageView.tag = 111;

        [annotationView addSubview:imageView];*/
        annotationView.image=img;
        return annotationView;
    }
    return nil;
}
- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
	if([gestureRecognizer isMemberOfClass:[UILongPressGestureRecognizer class]] && (gestureRecognizer.state == UIGestureRecognizerStateEnded)) {
		[self.stateMapView removeGestureRecognizer:gestureRecognizer]; //avoid multiple pins to appear when holding on the screen
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.stateMapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.stateMapView convertPoint:touchPoint toCoordinateFromView:self.stateMapView];
	
    Annotation *annotation = [[Annotation alloc] initWithLocation:touchMapCoordinate];
    annotation.title = [NSString stringWithFormat:@"Dropped Pin"];
    annotation.locationType = @"dropped";
    [self.stateMapView addAnnotation:annotation];
    [self.stateMapView selectAnnotation:annotation animated:YES];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Map Delegate

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonView *aView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon *)overlay];
        
        aView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
        aView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.65];
        //        aView.strokeColor = [UIColor whiteColor];
        //        aView.fillColor = [[UIColor colorWithRed:0.9176 green:0.9098 blue:0.8117 alpha:1.0] colorWithAlphaComponent:0.5];;
        
        aView.lineWidth = 2;
        return aView;
    }
    return nil;
}

#pragma mark - Utilities

+ (NSArray *)usStatesAndTerritoryOverlays {
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"states" ofType:@"json"];
    NSData *overlayData = [NSData dataWithContentsOfFile:fileName];
    id parsedJSON = [NSJSONSerialization JSONObjectWithData:overlayData options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *states = [parsedJSON valueForKeyPath:@"states.state"];
    
    NSMutableArray *overlays = [NSMutableArray array];
    
        for (NSDictionary *state in states) {
//    NSDictionary *state = [states objectAtIndex:0];
    NSArray *points = [state valueForKeyPath:@"point"];
    
    NSInteger numberOfCoordinates = [points count];
    CLLocationCoordinate2D *polygonPoints = malloc(numberOfCoordinates * sizeof(CLLocationCoordinate2D));
    
    NSInteger index = 0;
    for (NSDictionary *pointDict in points) {
        polygonPoints[index] = CLLocationCoordinate2DMake([[pointDict valueForKeyPath:@"latitude"] floatValue], [[pointDict valueForKeyPath:@"longitude"] floatValue]);
        index++;
    }
    
    MKPolygon *overlayPolygon = [MKPolygon polygonWithCoordinates:polygonPoints count:numberOfCoordinates];
    overlayPolygon.title = [state valueForKey:@"name"];
    
    [overlays addObject:overlayPolygon];
    
    free(polygonPoints);
    }
    
    return overlays;
}


@end
