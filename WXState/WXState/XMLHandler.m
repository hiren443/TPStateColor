
#import "XMLHandler.h"


@implementation XMLHandler
@synthesize delegate;

- (void)parseXMLFileAt:(NSString*)strPath{
    infoTxt = [NSMutableString string];
    NSData *data = [NSData dataWithContentsOfFile:strPath];
	_parser=[[NSXMLParser alloc] initWithData:data];
	_parser.delegate=self;
	[_parser parse];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    NSLog(@"Attribute %@  Element Name %@", attributeDict, elementName);
    //<marker x="142" y="248" name="London" IATA="LHR" temperature="4" wind="260" at="15" weather="FOG" =color="yellow" />

	if ([elementName isEqualToString:@"markers"]){
        stAr=[[NSMutableArray alloc] init];
	}
	
	if ([elementName isEqualToString:@"marker"]) {
		
		_itemdictionary=[[NSMutableDictionary alloc] init];
        [_itemdictionary setDictionary:attributeDict];
        [stAr addObject:_itemdictionary];
	}
	
	if ([elementName isEqualToString:@"lat"]) {
		[_itemdictionary setValue:[attributeDict valueForKey:@"lat"] forKey:@"lat"];
	}
	
    if ([elementName isEqualToString:@"long"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"long"] forKey:@"lng"];
	}
    if ([elementName isEqualToString:@"name"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"name"] forKey:@"name"];
	}
    if ([elementName isEqualToString:@"IATA"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"IATA"] forKey:@"IATA"];
	}
    if ([elementName isEqualToString:@"temperature"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"temperature"] forKey:@"temperarure"];
	}
    if ([elementName isEqualToString:@"wind"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"wind"] forKey:@"wind"];
	}
    if ([elementName isEqualToString:@"at"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"at"] forKey:@"at"];
	}
    if ([elementName isEqualToString:@"weather"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"weather"] forKey:@"weather"];
	}
    if ([elementName isEqualToString:@"color"]) {
        [_itemdictionary setValue:[attributeDict valueForKey:@"color"] forKey:@"color"];
	}

    if ([elementName isEqualToString:@"info"]){
        [infoTxt setString:@""];
	}
    if ([elementName isEqualToString:@"urgent"]){
        [infoTxt setString:@""];
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    [infoTxt appendString:string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	if([elementName isEqualToString:@"info"]){
        [[NSUserDefaults standardUserDefaults] setValue:infoTxt forKey:@"info"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([elementName isEqualToString:@"urgent"]){
        [[NSUserDefaults standardUserDefaults] setValue:infoTxt forKey:@"urgent"];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}
    else if([elementName isEqualToString:@"marker"]) {
        [stAr addObject:_itemdictionary];

    }
    else if([elementName isEqualToString:@"markers"]) {
                NSLog(@"State Ar %d", stAr.count);
        if ((delegate!=nil)&&([delegate respondsToSelector:@selector(finishedParsing:)])) {
            [delegate finishedParsing:stAr];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	

}
@end
