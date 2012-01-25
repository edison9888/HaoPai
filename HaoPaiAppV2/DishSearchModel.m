//
//  DishSearchModel.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DishSearchModel.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@implementation DishSearchModel

@synthesize asiRequest;

//=========================================================== 
// dealloc
//=========================================================== 
- (void)dealloc
{
    [asiRequest release];
    asiRequest = nil;
	
    [super dealloc];
}


- (BOOL)isEmpty {
	return !_items.count;
}

- (void)cancel {
	if (asiRequest) {
		[asiRequest cancel];
		[_delegates perform:@selector(modelDidCancelLoad:) withObject:self];
	}
}

- (void)search:(NSString*)text {
	[self cancel];
	
	if (TTIsStringWithAnyText(text)) {
		if (asiRequest) {
			[self.asiRequest cancel];
			[self.asiRequest clearDelegatesAndCancel];
			TT_RELEASE_SAFELY(asiRequest);
		} 
		[_delegates perform:@selector(modelDidStartLoad:) withObject:self];
		[self typeSearch:text];
		
	} else {
		TT_RELEASE_SAFELY(_items);
		[_delegates perform:@selector(modelDidChange:) withObject:self];
	}
	
}

-(void)typeSearch:(NSString*)text{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"haopai.caisuggest"]];
	self.asiRequest = [ASIFormDataRequest requestWithURL:url];
	[asiRequest setPostValue:text forKey:@"share_name" ];
	[asiRequest setPostValue:@"20" forKey:@"max_size" ];
	[self.asiRequest setRequestMethod:@"POST"];
	[self.asiRequest setDelegate:self];
	self.asiRequest.didFinishSelector = @selector(finishPoview:);
	self.asiRequest.didFailSelector = @selector(finishFail:);
	[self.asiRequest startAsynchronous];
}

-(void)finishFail:(ASIHTTPRequest *)request{
	TT_RELEASE_SAFELY(asiRequest);
	[_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}

-(void)finishPoview:(ASIHTTPRequest *)requests{
	NSDictionary *data =[[JSONDecoder decoder] objectWithData:[requests responseData]];
	//NSLog(@"data %@",data);
	if ([[data objectForKey:@"status"] intValue]==200) {
		self.items = [[data objectForKey:@"result"] objectForKey:@"lists"];
	}else {
		NSLog(@"response.rootObject %@",[[data objectForKey:@"result"] objectForKey:@"errormsg"]);
	}
	[_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}

@end
