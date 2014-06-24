#import "MyLocation.h"

@implementation MyLocation
@synthesize name = _name;
@synthesize lastSeen = _lastSeen;
@synthesize route = _route;
@synthesize coordinate = _coordinate;
@synthesize heading = _heading;

- (id)initWithName:(NSString*)name address:(NSString*)address heading:(NSString*)heading coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _lastSeen = [address copy];
        _coordinate = coordinate;
        _heading = [heading copy];
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]]) 
        return @"Unknown";
    else
        return _name;
}

- (NSString *)subtitle {
    return _lastSeen;
}



@end