//
//  UserBingInfoViewController.m
//  cookbook
//
//  Created by 高飞 on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserBingInfoViewController.h"
#import "NSStringAdditions.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@implementation UserBingInfoViewController

-(void) dealloc{
	TT_RELEASE_SAFELY(_navigationHeader);
    TT_RELEASE_SAFELY(_nameField);
	TT_RELEASE_SAFELY(_passwordField);
	TT_RELEASE_SAFELY(_aliasField);
	TT_RELEASE_SAFELY(_backFrame);
    [self setParController:nil];
	[super dealloc];
}


-(UIImageView *) navigationHeader{
	if (!_navigationHeader) {
		_navigationHeader = [[UIImageView alloc] 
							 initWithImage:[TTIMAGE(@"bundle://menu-top-bg.png")
											stretchableImageWithLeftCapWidth:1
											topCapHeight:44]];
		//_navigationHeader.backgroundColor = RGBCOLOR(94, 138, 0);
		[_navigationHeader setUserInteractionEnabled:YES];
		[self.view addSubview:_navigationHeader];
	}
	return _navigationHeader;
}

-(void) viewDidUnload{
	TT_RELEASE_SAFELY(_navigationHeader);
    TT_RELEASE_SAFELY(_nameField);
	TT_RELEASE_SAFELY(_passwordField);
	TT_RELEASE_SAFELY(_aliasField);
	TT_RELEASE_SAFELY(_backFrame);
	[super viewDidUnload];
}

- (void)loadView {
	[super loadView];
	self.navigationHeader.frame = CGRectMake(0, 0, 320, 44);
	//self.view.backgroundColor = kBackColor;
    titl = [[UILabel alloc] init];
	titl.text = @"完善信息";
	titl.font = [UIFont boldSystemFontOfSize:20];
	titl.textColor = [UIColor whiteColor];
    titl.shadowColor = [UIColor grayColor];
    titl.shadowOffset = CGSizeMake(0, -1.0);
	titl.textAlignment = UITextAlignmentCenter;
	titl.frame = CGRectMake(0, (44-20)/2, 320, 20);
	titl.backgroundColor = [UIColor clearColor];
	[self.navigationHeader addSubview:titl];
	[titl release];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:TTIMAGE(@"bundle://btn-return.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-30)/2, 50, 30);
	[self.navigationHeader addSubview:backButton];
    
    self.actionButton.frame = CGRectMake((320-68), (44-30)/2, 60, 30);
    
    self.backFrame.frame = CGRectMake(0,44,320,120);
    self.nameField.frame = CGRectMake(20,56,200,25);
    self.aliasField.frame = CGRectMake(20, 94, 280, 25);
    self.aliasField.text = [kAppDelegate.temporaryValues  objectForKey:@"nick"];
    self.passwordField.frame = CGRectMake(20, 134, 280, 25);
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[kAppDelegate HUDHide];
	self.navigationController.navigationBarHidden = YES;
	[self.nameField becomeFirstResponder];
}

-(void)backAction{
	//[self.navigationController popToRootViewControllerAnimated:YES];
}

-(UIImageView *) backFrame{
	if (!_backFrame) {
		_backFrame = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://zhuceBack.png") ];
		[self.view addSubview:_backFrame];
	}
	return _backFrame;
}

-(UITextField *) nameField{
	if (!_nameField) {
		_nameField = [[UITextField alloc] init];
		_nameField.placeholder = @"请输入注册邮箱";
		_nameField.borderStyle =  UITextBorderStyleNone;
		_nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_nameField.keyboardType = UIKeyboardTypeEmailAddress;
		_nameField.font = [UIFont systemFontOfSize:15];
		[self.view addSubview:_nameField];
	}
	return _nameField;
}

-(UITextField *) aliasField{
	if (!_aliasField) {
		_aliasField = [[UITextField alloc] init];
		_aliasField.placeholder = @"你的昵称";
		_aliasField.borderStyle =  UITextBorderStyleNone;
		_aliasField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_aliasField.keyboardType = UIKeyboardTypeASCIICapable;
		_aliasField.font = [UIFont systemFontOfSize:15];
		[self.view addSubview:_aliasField];
	}
	return _aliasField;
}

-(UITextField *) passwordField{
	if (!_passwordField) {
		_passwordField = [[UITextField alloc] init];
		_passwordField.placeholder = @"请输入密码";
		_passwordField.secureTextEntry = YES;
		_passwordField.borderStyle =  UITextBorderStyleNone;
		_passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_passwordField.keyboardType = UIKeyboardTypeASCIICapable;
		_passwordField.font = [UIFont systemFontOfSize:15];
		[self.view addSubview:_passwordField];
	}
	return _passwordField;
}

-(UIButton *) actionButton{
	if (!_actionButton) {
		_actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[_actionButton setImage:TTIMAGE(@"bundle://btn-complete.png")
                       forState:UIControlStateNormal];
        [_actionButton setImage:TTIMAGE(@"bundle://wancheng_on.png")
                       forState:UIControlStateHighlighted];
		//[_actionButton setTitle:@"登录" forState:UIControlStateNormal];
		_actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
		[_actionButton addTarget:self
                          action:@selector(actionTounch) 
                forControlEvents:UIControlEventTouchUpInside];
		[self.navigationHeader addSubview:_actionButton];
	}
	return _actionButton;
}

-(void)actionTounch{
    if ([self.nameField.text isEmptyOrWhitespace]) {
		[kAppDelegate alert:@"" message:@"请输入注册的邮箱"];
		return;
	}
	
	if ([self.passwordField.text isEmptyOrWhitespace]) {
		[kAppDelegate alert:@"" message:@"请输入您的密码"];
		return;
	}
    
    if ([self.aliasField.text isEmptyOrWhitespace]) {
        [kAppDelegate alert:@"" message:@"请输入您的昵称"];
        return;
    }
    
    [kAppDelegate HUDShow:@"绑定中" yOffset:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"passport.connectbindreg"]];
    //NSLog(@"url %@",[NSString stringWithFormat:kRESTBaseUrl,@"passport.connectbindreg"]);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
   // NSLog(@"email %@ %@",self.nameField.text,self.aliasField.text);
    //NSLog(@"token %@ openid %@",
     //     [kAppDelegate.temporaryValues objectForKey:@"token"],
       //   [kAppDelegate.temporaryValues objectForKey:@"openid"]);
    [request setPostValue:self.nameField.text forKey:@"email" ];
    [request setPostValue:self.aliasField.text forKey:@"nick"];
    [request setPostValue:self.passwordField.text forKey:@"pwd"];
    [request setPostValue:[kAppDelegate.temporaryValues objectForKey:@"siteid"] forKey:@"siteid"];
    [request setPostValue:[kAppDelegate.temporaryValues objectForKey:@"openid"] forKey:@"openid"];
    [request setPostValue:[kAppDelegate.temporaryValues objectForKey:@"token"] forKey:@"token"];
    if (![[kAppDelegate.temporaryValues objectForKey:@"secret"]  isEmptyOrWhitespace]) {
        [request setPostValue:[kAppDelegate.temporaryValues objectForKey:@"secret"] forKey:@"secret"];
    }
        
    
    [request setRequestMethod:@"POST"];
	[request setDelegate:self];
	request.didFinishSelector = @selector(finishRequest:);
	request.didFailSelector = @selector(finishFail:);
	[request startAsynchronous];
}

-(void)finishFail:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	[kAppDelegate alert:@"" message:[[request error] localizedDescription]];
}


-(void)finishRequest:(ASIHTTPRequest *)request{
	[kAppDelegate HUDHide];
	NSDictionary *data =[[JSONDecoder decoder] objectWithData:[request responseData]];
	//NSLog(@"data %@",data);
	if ([[data objectForKey:@"status"] intValue]==200) {
		//保存用户设置
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"sessionkey" ] 
					 forKey:@"sessionkey" ];
		[defaults setObject:[NSString stringWithFormat:@"%@",[[data objectForKey:@"result"]objectForKey:@"userid" ]]
					 forKey:@"userid" ];
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"email" ] 
					 forKey:@"username" ];
        [defaults setObject:[[data objectForKey:@"result"]objectForKey:@"username" ] 
					 forKey:@"nick" ];
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"avatar" ] 
					 forKey:@"useravatar" ];
		
		[defaults synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loveAction" object:nil];
        
		[kAppDelegate.temporaryValues setObject:@"1" forKey:@"loginType"];
        [self.navigationController popToViewController:[kAppDelegate.temporaryValues objectForKey:@"loginController"] 
                                              animated:YES];
	}else {
		[kAppDelegate alert:@"" message:[[data objectForKey:@"result"]objectForKey:@"errormsg"]];
	}
}

@end
