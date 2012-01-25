//
//  QVerifyWebViewController.m
//  QWeiboSDK4iOSDemo
//
//  Created   on 11-1-14.
//   
//

#import "QVerifyWebViewController.h"
#import "QWeiboSyncApi.h"
#import "NSURL+QAdditions.h"


#define VERIFY_URL @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="

@implementation QVerifyWebViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationHeader.frame = CGRectMake(0, 0, 320, 44);
	
	UILabel *titl = [[UILabel alloc] init];
	titl.text = @"用户授权";
	titl.font = [UIFont systemFontOfSize:20];
	titl.textColor = [UIColor whiteColor];
	titl.shadowColor = [UIColor grayColor];
	titl.textAlignment = UITextAlignmentCenter;
	titl.frame = CGRectMake((320-100)/2, 12, 100, 20);
	titl.backgroundColor = [UIColor clearColor];
	[self.navigationHeader addSubview:titl];
	[titl release];
	
	TTButton *backButton = [TTButton buttonWithStyle:@"blackBackButton:" 
											   title:@"返回"];
	backButton.font = [UIFont systemFontOfSize:13];
	[backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-33)/2, 55, 33);
	[self.navigationHeader addSubview:backButton];
	
	mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, 370)];
	mWebView.delegate = self;
	[self.view addSubview:mWebView];
	
	NSDictionary *params = [NSURL parseURLQueryString:[kAppDelegate.temporaryValues objectForKey:@"qqRetString"]];
	
	NSString *url = [NSString stringWithFormat:@"%@%@", VERIFY_URL, [params objectForKey:@"oauth_token"]];
	NSURL *requestUrl = [NSURL URLWithString:url];
	NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
	[mWebView loadRequest:request];
}

-(void) viewDidUnload{
	TT_RELEASE_SAFELY(_navigationHeader);
	[super viewDidUnload];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}



-(void) dealloc{
	TT_RELEASE_SAFELY(_navigationHeader);
	[super dealloc];
}


-(UIImageView *) navigationHeader{
	if (!_navigationHeader) {
		_navigationHeader = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://navigation-Background.png")];
		_navigationHeader.backgroundColor = [UIColor clearColor];
		[_navigationHeader setUserInteractionEnabled:YES];
		[self.view addSubview:_navigationHeader];
	}
	return _navigationHeader;
}

-(void)backAction{
	[self.navigationController popViewControllerAnimated:YES];
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
	NSString *verifier = [self valueForKey:@"oauth_verifier" ofQuery:query];
	
	if (verifier && ![verifier isEqualToString:@""]) {
		

		
		QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
		NSString *retString = [api getAccessTokenWithConsumerKey:kQqOAuthConsumerKey 
												  consumerSecret:kQqOAuthConsumerSecret
												 requestTokenKey:@""
											  requestTokenSecret:@"" 
														  verify:verifier];
		NSLog(@"\nget access token:%@", retString);

	
		return NO;
	}
	
	return YES;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[kAppDelegate HUDHide];
	self.navigationController.navigationBarHidden = YES;
}


@end
