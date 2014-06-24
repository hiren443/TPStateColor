#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation> {
    NSString *_name;
    NSString *_lastSeen;
    NSString *_route;
    NSString *_heading;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *name;
@property (copy) NSString *lastSeen;
@property (copy) NSString *route;
@property (copy) NSString *heading;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name address:(NSString*)address heading:(NSString*)heading coordinate:(CLLocationCoordinate2D)coordinate;

@end
