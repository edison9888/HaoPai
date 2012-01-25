//
//  CitySearchModel.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CitySearchModel.h"

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
@implementation CitySearchModel

- (id)init{
	if (self = [super init]) {
		_items = [[NSMutableArray alloc] init];
	}
	return self;
}

- (BOOL)isEmpty {
	return !_items.count;
}


- (void)search:(NSString*)text {
	if (TTIsStringWithAnyText(text)) {
		text = [[text stringByTrimmingCharactersInSet:[NSCharacterSet 
													   whitespaceCharacterSet]]
				stringByAppendingString:@"%"];
		
		FMResultSet *rs =	[kAppDelegate.db executeQuery:kCitySql,text,text,text];
		[_items removeAllObjects];
		while ([rs next]) {
			NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithCapacity:2];
			[temp setObject:[rs stringForColumn:@"id"] forKey:@"id"];
			[temp setObject:[rs stringForColumn:@"cn"] forKey:@"cn"];
			[_items addObject:temp];
		}
		[rs close];
		[_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
	} else {
		[_items removeAllObjects];
		[_delegates perform:@selector(modelDidChange:) withObject:self];
	}	
}




@end
