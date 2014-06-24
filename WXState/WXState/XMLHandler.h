

#import <Foundation/Foundation.h>


@protocol XMLHandlerDelegate <NSObject>

@optional
- (void)finishedParsing:(NSArray*)flightContent;
- (void)finishedParsingError:(NSString*)infoORurgent check:(BOOL)status;

@end


@interface XMLHandler : NSObject <NSXMLParserDelegate>{

	NSXMLParser *_parser;
	NSString *_rootPath;
	id<XMLHandlerDelegate> delegate;
	NSMutableDictionary *_itemdictionary;
	NSMutableArray *stAr;
    NSMutableString *infoTxt;
}

@property (nonatomic, retain) id<XMLHandlerDelegate> delegate;
- (void)parseXMLFileAt:(NSString*)strPath;
@end
