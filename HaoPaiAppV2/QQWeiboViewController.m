//
//  QQWeiboViewController.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QQWeiboViewController.h"
#import "QWeiboSyncApi.h"
#import "NSURL+QAdditions.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "NSDictionaryAdditions.h"
#define VERIFY_URL @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="

@implementation QQWeiboViewController

-(void) loadView{
	[super loadView];
	[kAppDelegate HUDHide];
	self.title = @"用户认证";
	
	NSDictionary *params = [NSURL parseURLQueryString:[kAppDelegate.temporaryValues objectForKey:@"qqRetString"]];
	NSString *url = [NSString stringWithFormat:@"%@%@", VERIFY_URL, [params objectForKey:@"oauth_token"]];
	NSURL *requestUrl = [NSURL URLWithString:url];
	NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
	[_webView loadRequest:request];
}

-(void)cancelAction:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark private methods
-(NSString*) valueForKey:(NSString *)key ofQuery:(NSString*)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	for(NSString *aPair in pairs){
		NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
		if([keyAndValue count] != 2) continue;
		if([[keyAndValue objectAtIndex:0] isEqualToString:key]){
			return [keyAndValue objectAtIndex:1];
		}
	}
	return nil;
}

#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
	NSString *query = [[request URL] query];
    NSLog(@"query %@",[[request URL] absoluteURL]);
	NSString *verifier = [self valueForKey:@"oauth_verifier" ofQuery:query];
	if (verifier && ![verifier isEqualToString:@""]) {
		[kAppDelegate HUDShow:@"授权中" yOffset:@""];
		[self performSelector:@selector(setSync:)
				   withObject:verifier
				   afterDelay:0.0];
		return NO;
	}
	return YES;
}

-(void)setSync:(NSString*)verifier{    
    NSDictionary *params = [NSURL parseURLQueryString:[kAppDelegate.temporaryValues objectForKey:@"qqRetString"]];
	//NSLog(@"params %@",params);
	QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
	NSString *retString = [api getAccessTokenWithConsumerKey:kQqOAuthConsumerKey 
											  consumerSecret:kQqOAuthConsumerSecret
											 requestTokenKey:[params objectForKey:@"oauth_token"]
										  requestTokenSecret:[params objectForKey:@"oauth_token_secret"]
													  verify:verifier];
	NSDictionary *access = [NSURL parseURLQueryString:retString];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"Account.setUserSyncInfo"]];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:[defaults objectForKey:@"sessionkey"] forKey:@"ssid"];
	//NSLog(@"userid %@",[defaults objectForKey:@"userid"]);
	[request setPostValue:[defaults objectForKey:@"userid"] forKey:@"uid"];
	[request setPostValue:@"2" forKey:@"siteid"];
	[request setPostValue:[access objectForKey:@"oauth_token"] forKey:@"token"];
	[request setPostValue:[access objectForKey:@"oauth_token_secret"] forKey:@"secret"];
	[request setRequestMethod:@"POST"];
	[request setDelegate:self];
	request.didFinishSelector =  @selector(finishUpdata:);
	request.didFailSelector = @selector(failUpdata:);
	[request startAsynchronous];
}


-(void)finishUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
	//NSLog(@"errormsg %@",[[data objectForKey:@"result"]objectForKey:@"errormsg" ]);
	if ([[data objectForKey:@"status"] intValue]==200) {
		[kAppDelegate showWithCustomView:[[data objectForKey:@"result"]objectForKey:@"errormsg" ]];
	}else {
		[kAppDelegate showWithCustomView:[[data objectForKey:@"result"]objectForKey:@"errormsg" ]];
	}
	[self.navigationController performSelector:@selector(popViewControllerAnimated:) 
									withObject: (id) kCFBooleanTrue 
									afterDelay: 1.0];
}


-(void)failUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:[request.error localizedDescription]];
	[self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidFinishLoad:(UIWebView*)webView {
	[super webViewDidFinishLoad:webView];
	self.title = @"用户授权";
}


@end
