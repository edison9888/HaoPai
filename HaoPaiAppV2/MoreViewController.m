//
//  MoreViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "DCRoundSwitch.h"
#import "ASIFormDataRequest.h"
#import "SynchronousItem.h"
#import "JSONKit.h"
#import "MoreDataSource.h"
#import "QWeiboSyncApi.h"
#import "QQWeiboViewController.h"
#import "OAuthEngine.h"
#import "OAuthController.h"
#import "SystemSettingItem.h"
#import "MyTTPostController.h"
#import "ToolUntil.h"
#import "NSStringAdditions.h"
@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[[TTNavigator navigator].URLMap from:@"tt://post"
							toViewController:self selector:@selector(post:)];
	}
	return self;
}

-(void)loadView{
    [super loadView];
    _titl.text = @"更多";
    
    self.tableView.frame = CGRectMake(0, 44, 320, 371);
    self.variableHeightRows = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:TTIMAGE(@"bundle://btn-return.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-30)/2, 50, 30);
	[_navigationHeader addSubview:backButton];
    
    
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self getSyn];
}

-(void)getSyn{
	[kAppDelegate HUDShow:@"" yOffset:@"0"];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//NSLog(@"userid %@",[defaults objectForKey:@"userid"]);
    // NSLog(@"ssid %@",[defaults objectForKey:@"sessionkey"]);
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"Account.getUserSyncInfo"]];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:[defaults objectForKey:@"sessionkey"] forKey:@"ssid"];
	[request setPostValue:[defaults objectForKey:@"userid"] forKey:@"uid"];
	[request setRequestMethod:@"POST"];
	[request setDelegate:self];
	request.didFinishSelector = @selector(finishSyn:);
	request.didFailSelector = @selector(failUpdata:);
	[request startAsynchronous];
}

-(void)finishSyn:(ASIHTTPRequest *)request{
    self.tableView.frame = CGRectMake(0, 0, 320, 480);
	[kAppDelegate HUDHide];
	NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
	//NSLog(@"syn %@",[[data objectForKey:@"result"]objectForKey:@"errormsg" ]);
	if ([[data objectForKey:@"status"] intValue]==200) {
		NSDictionary * list  = [[data objectForKey:@"result"] objectForKey:@"lists"] ;
		UISwitch* switchy = [[[UISwitch alloc] init] autorelease];
		switchy.tag = 3;
		if ([[[list objectForKey:@"3"] objectForKey:@"Has"] intValue]==1) {
			switchy.on = true;
		}else {
			switchy.on =  false;
		}
		[switchy addTarget:self
					action:@selector(syncAction:)
		  forControlEvents:UIControlEventValueChanged];
		
		SynchronousItem * sina = [SynchronousItem itemWithCaption:@"同步新浪微博" control:switchy];
		UISwitch* switchy2 = [[[UISwitch alloc] init] autorelease];
		switchy2.tag = 2;
		
		[switchy2 addTarget:self
					 action:@selector(syncAction:)
		   forControlEvents:UIControlEventValueChanged];
        
		
		if ([[[list objectForKey:@"2"] objectForKey:@"Has"] intValue]==1) {
			switchy2.on = true;
		}else {
			switchy2.on =  false;
		}
		
		sina.imageUrl = @"bundle://sina.png";
		SynchronousItem * qq = [SynchronousItem itemWithCaption:@"同步腾讯微博" control:switchy2];
		qq.imageUrl = @"bundle://tengxun.png";
        
        
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		self.dataSource = [MoreDataSource dataSourceWithObjects:@"",
						   qq,sina,
                           [SystemSettingItem itemWithText:[defaults objectForKey:@"nick"] 
                                                   caption:@"退出登录" imageURL:@""],
                           [SystemSettingItem itemWithText:@"城市切换"
                                                   caption:@"长沙" imageURL:@""],
                           [SystemSettingItem itemWithText:@"邀请和关注"
                                                   caption:@"" imageURL:@""],
                           [SystemSettingItem itemWithText:@"关于"
                                                   caption:[NSString stringWithFormat:@"版本号:%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]
                                                  imageURL:@""],
                           [SystemSettingItem itemWithText:@"意见反馈"
                                                   caption:@"" imageURL:@""],
                           [SystemSettingItem itemWithText:@"我要评分"
                                                   caption:@"" imageURL:@""],
                           nil];
		[self.tableView reloadData];
        
	}else {
		[kAppDelegate showWithCustomView:[[data objectForKey:@"result"]objectForKey:@"errormsg" ]];
	}
}

-(void)failUpdata:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:[[request error] localizedDescription]];
}


-(void)syncAction:(id)sender{
	switch (((UISwitch*)sender).tag) {
		case 2:
		{
			if (((UISwitch*)sender).on) {
				[kAppDelegate HUDShow:@"" yOffset:@""];
				[self performSelector:@selector(toQQ) withObject:nil afterDelay:0.0];
			}else {
				[kAppDelegate HUDShow:@"" yOffset:@""];
				[self performSelector:@selector(deleteUserSyncInfo:) withObject:@"2" afterDelay:0.0];
			}
			break;
			
		}
		case 3:
		{
			if (((UISwitch*)sender).on) {
				[kAppDelegate HUDShow:@"" yOffset:@""];
				[self performSelector:@selector(toSina) withObject:nil afterDelay:0.0];
			}else {
				[kAppDelegate HUDShow:@"" yOffset:@""];
				[self performSelector:@selector(deleteUserSyncInfo:) withObject:@"3" afterDelay:0.0];
			}
            
			break;
		}
			
            
		default:
			break;
	}
	
}

- (UIViewController*)post:(NSDictionary*)query {
	TTPostController* controller = [[[MyTTPostController alloc] initWithNavigatorURL:nil
                                                                               query:
									 [NSDictionary dictionaryWithObjectsAndKeys:@"", @"text", nil]]
									autorelease];
	controller.title = @"意见反馈";
	controller.delegate = self;
	controller.originView = [query objectForKey:@"__target__"];
    [kAppDelegate performSelector:@selector(showWithTextView:) withObject:@"麻烦在留言中留下联系方式,QQ" afterDelay:0.4];
	return controller;
}

//建议提交
-(BOOL) postController:(TTPostController *)postController willPostText:(NSString *)text{
	if (![text isEmptyOrWhitespace]) {
		[kAppDelegate HUDShow:@"提交中" yOffset:@"0"];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"common.feedback"]];
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		if (TTIsStringWithAnyText([defaults objectForKey:@"sessionkey"])) {
			text = [NSString stringWithFormat:@"%@ 注:用户编号为-%@",text,
					[defaults objectForKey:@"userid"]];
            [request setPostValue:[defaults objectForKey:@"userid"] forKey:@"uid"];
		}
		[request setPostValue:text forKey:@"content"];
		[request setPostValue:@"recipe-iphone" forKey:@"app"];
		[request setPostValue:[ToolUntil getDeviceVersion] forKey:@"phone_type"];
        [request setPostValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
                       forKey:@"version"];
        [request setPostValue:[NSString stringWithFormat:@"IOS %@",[[UIDevice currentDevice] systemVersion]]
                       forKey:@"sdk"];
		
		[request setRequestMethod:@"POST"];
		[request startSynchronous];
		[kAppDelegate HUDHide];
		NSError *error = [request error];
		if (!error) {
			//NSLog(@"post %@",[request responseString]);
			NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
			[kAppDelegate performSelector:@selector(showWithCustomView:)
							   withObject:[[data objectForKey:@"result"]objectForKey:@"errormsg" ]
							   afterDelay:0.5];
			return YES;
		}else {
			[kAppDelegate alert:@"错误" message:@"提交失败请检查网络链接"];
			return NO;
		}
	}else {
		return NO;
	}
}


-(void)deleteUserSyncInfo:(NSString*)siteId{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//NSLog(@"userid %@",[defaults objectForKey:@"userid"]);
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"account.deleteUserSyncInfo"]];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:[defaults objectForKey:@"sessionkey"] forKey:@"ssid"];
    [request setPostValue:[defaults objectForKey:@"userid"] forKey:@"uid"];
	[request setPostValue:siteId forKey:@"siteid"];
	[request setRequestMethod:@"POST"];
	[request setDelegate:self];
	request.didFinishSelector = @selector(finishDelete:);
	request.didFailSelector = @selector(failUpdata:);
	[request setShouldContinueWhenAppEntersBackground:YES];
	[request startAsynchronous];
}

-(void)finishDelete:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	//NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
	//NSLog(@"response.rootObject %@",[[data objectForKey:@"result"] objectForKey:@"errormsg"]);
	[self getSyn];
}

-(void)toSina{
	OAuthEngine *_engine = [[[OAuthEngine alloc] initOAuthWithDelegate: self] autorelease];
	_engine.consumerKey = kSinaOAuthConsumerKey;
	_engine.consumerSecret = kSinaOAuthConsumerSecret;
	
	UIViewController *controller = [OAuthController controllerToEnterCredentialsWithEngine: _engine delegate: self];
	
	[self.navigationController pushViewController:controller animated:YES];
}

-(void)toQQ{
	QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
	NSString *retString = [api getRequestTokenWithConsumerKey:kQqOAuthConsumerKey 
											   consumerSecret:kQqOAuthConsumerSecret];
	//NSLog(@"Get requestToken:%@", retString);
	
	[kAppDelegate.temporaryValues setObject:retString forKey:@"qqRetString"];
	//[appDelegate parseTokenKeyWithResponse:retString];
	
	QQWeiboViewController *verifyController = [[QQWeiboViewController alloc] init];
	
	[self.navigationController pushViewController:verifyController animated:YES];
	
	[verifyController release];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([((SystemSettingItem*)object).caption isEqualToString:@"退出登录"]){//登出
		UIAlertView *sAlert = [[UIAlertView alloc] initWithTitle:@"提示"
														 message:@"退出当前账号"
														delegate:self
											   cancelButtonTitle:@"否"
											   otherButtonTitles:@"是",nil];
		[sAlert show];
		[sAlert release];
    }else if([((SystemSettingItem*)object).text isEqualToString:@"关于"]){
        TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://viewController/AboutViewController"];
        urlAction.animated = YES;
        [[TTNavigator navigator] performSelector:@selector(openURLAction:) 
                                      withObject:urlAction 
                                      afterDelay:0.0];
    }else if([((SystemSettingItem*)object).text isEqualToString:@"意见反馈"]){
		TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"tt://post"];
		urlAction.animated = YES;
		[[TTNavigator navigator] performSelector:@selector(openURLAction:) 
									  withObject:urlAction 
									  afterDelay:0.0];
    }else if ([((TTTableTextItem*)object).text isEqualToString:@"我要评分"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=465278695"]];
	}
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"是"]) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults removeObjectForKey:@"sessionkey"];
		[defaults removeObjectForKey:@"userid"];
		[defaults removeObjectForKey:@"username"];
		[defaults synchronize];
        [kAppDelegate.temporaryValues removeObjectForKey:@"loginType"];
        [kAppDelegate.temporaryValues removeObjectForKey:@"loginController"];
        [[((MoreDataSource*)self.dataSource).items objectAtIndex:0] removeObjectAtIndex:1];
		[[((MoreDataSource*)self.dataSource).items objectAtIndex:0] replaceObjectAtIndex:0 
																			  withObject:[SystemSettingItem itemWithText:@"" caption:@"未登录" imageURL:@"bundle://douwo.png"]];
		[self.tableView reloadData];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"loginOut" object:nil];
	}
}

@end
