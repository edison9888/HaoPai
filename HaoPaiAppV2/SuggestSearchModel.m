//
//  SuggestSearchModel.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuggestSearchModel.h"
#import "ASIFormDataRequest.h"

@implementation SuggestSearchModel

-(void)typeSearch:(NSString*)text{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"haopai.wordsuggest"]];
	self.asiRequest = [ASIFormDataRequest requestWithURL:url];
	[asiRequest setPostValue:text forKey:@"word" ];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[asiRequest setPostValue:[defaults objectForKey:@"city_id"] forKey:@"city_id" ];
	//[asiRequest setPostValue:@"20" forKey:@"max_size" ];
	[self.asiRequest setRequestMethod:@"POST"];
	[self.asiRequest setDelegate:self];
	self.asiRequest.didFinishSelector = @selector(finishPoview:);
	self.asiRequest.didFailSelector = @selector(finishFail:);
	[self.asiRequest startAsynchronous];
}

@end
