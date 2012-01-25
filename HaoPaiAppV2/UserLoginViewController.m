//
//  LoginViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserLoginViewController.h"
#import "HMGLTransitionManager.h"
#import "FlipTransition.h"
#import "NSStringAdditions.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
@implementation UserLoginViewController

-(void)dealloc{
    [self setParController:nil];
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    _pic = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://big-img.png")];
    _pic.frame = CGRectMake(0, 0, 320, 206);
    [self.view addSubview:_pic];
    [_pic release];
    UIView *_shadowUp = [[UIView alloc] init];

    UIImageView *_shadow = [[UIImageView alloc] initWithImage:
                              TTIMAGE(@"bundle://yinying.png")];
    _shadow.frame = CGRectMake(0, 0, 320, 206);
    [self.view addSubview:_shadow];
    [_shadowUp release];
    
    _container = [[UIView alloc] initWithFrame:CGRectMake(0, 206, 320, 450)];
    _container.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_container];
    [_container release];
    
    UIImageView *_back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 94)];
    _back.image = TTIMAGE(@"bundle://denglu.png");
    [_container addSubview:_back];
    [_back release];
    
    _nameField = [[UITextField alloc] initWithFrame:CGRectMake(70, 24, 200, 21)];
    _nameField.placeholder = @"请输入电子邮箱或手机号码";
    _nameField.keyboardType = UIKeyboardTypeEmailAddress;
    _nameField.font = [UIFont systemFontOfSize:16];
    _nameField.textColor = RGBCOLOR(153, 153, 153);
    _nameField.delegate = self;
    [_container addSubview:_nameField];
    [_nameField release];
    
    _passField = [[UITextField alloc] initWithFrame:CGRectMake(70, 64, 200, 21)];
    _passField.placeholder = @"请输入密码";
    _passField.secureTextEntry = YES;
    _passField.font = [UIFont systemFontOfSize:16];
    _passField.textColor = RGBCOLOR(153, 153, 153);
    _passField.delegate = self;
    [_container addSubview:_passField];
    [_passField release];
    
    UIButton *_loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setImage:TTIMAGE(@"bundle://btn-index-login.png") 
                     forState:UIControlStateNormal];
    _loginButton.frame = CGRectMake(10, 104, 148, 40);
    [_loginButton addTarget:self action:@selector(loginAction)
           forControlEvents:UIControlEventTouchUpInside];
    [_container addSubview:_loginButton];
    
    UIButton *_registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerButton setImage:TTIMAGE(@"bundle://btn-index-register.png") 
                     forState:UIControlStateNormal];
    _registerButton.frame = CGRectMake(168, 104, 148, 40);
    [_registerButton addTarget:self action:@selector(registerAction)
           forControlEvents:UIControlEventTouchUpInside];
    [_container addSubview:_registerButton];
    
    UIButton *_sinaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sinaButton setImage:TTIMAGE(@"bundle://login_with_sina.png") 
               forState:UIControlStateNormal];
    [_sinaButton setImage:TTIMAGE(@"bundle://login_with_sina_on.png") 
               forState:UIControlStateHighlighted];
    
    _sinaButton.frame = CGRectMake(0, 147, 320, 40);
    [_container addSubview:_sinaButton];
    
    UIButton *_qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_qqButton setImage:TTIMAGE(@"bundle://login_with_qq.png") 
               forState:UIControlStateNormal];
    [_qqButton setImage:TTIMAGE(@"bundle://login_with_qq_on.png") 
               forState:UIControlStateHighlighted];
    
    _qqButton.frame = CGRectMake(0, 187, 320, 40);
    [_container addSubview:_qqButton];
    
    UIImageView *_copyright = [[UIImageView alloc] initWithFrame:CGRectMake(0, 223, 320, 29)];
    _copyright.image = TTIMAGE(@"bundle://txt_copyright.png");
    [_container addSubview:_copyright];
    [_copyright release];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_container.frame.origin.y!=-15) {
        [UIView animateWithDuration:0.3 
                              delay:0 
                            options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn)
                         animations:^{
                             //168
                             _container.frame = CGRectMake(0, -15, 320, 500);
                             
                         } 
                         completion:^(BOOL finished){
                             
                         }];
    }
    return  YES;
}

//登陆
-(void)loginAction{
    if ([_nameField.text isEmptyOrWhitespace]) {
		[kAppDelegate alert:@"" message:@"请输入注册的邮箱"];
		return;
	}
	
	if ([_passField.text isEmptyOrWhitespace]) {
		[kAppDelegate alert:@"" message:@"请输入您的密码"];
		return;
	}
    
    [kAppDelegate HUDShow:@"登录中" yOffset:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"Account.login"]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    //NSLog(@"self.nameField.text %@",self.nameField.text);
    //NSLog(@"self.passwordField.text %@",self.passwordField.text);
    [request setPostValue:_nameField.text forKey:@"name" ];
    [request setPostValue:_passField.text forKey:@"pwd"];
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
		
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"Ssid" ] 
					 forKey:@"sessionkey" ];
		[defaults setObject:[NSString stringWithFormat:@"%@",[[data objectForKey:@"result"]objectForKey:@"UserId" ]]
					 forKey:@"userid" ];
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"Name" ] 
					 forKey:@"username" ];
        [defaults setObject:[[data objectForKey:@"result"]objectForKey:@"Nick" ] 
					 forKey:@"nick" ];
        
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"Avatar" ] 
					 forKey:@"useravatar" ];
		
		[defaults synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:nil];
		
        [_nameField resignFirstResponder];
        [_passField resignFirstResponder];
        
        FlipTransition *flip =[[[FlipTransition alloc] init] autorelease];
        flip.transitionType = FlipTransitionRight;
        [[HMGLTransitionManager sharedTransitionManager] 
         setTransition:flip];
        [[HMGLTransitionManager sharedTransitionManager] popViewController:self];
        
		[[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:nil];
		
	}else {
		[kAppDelegate alert:@"" message:[[data objectForKey:@"result"]objectForKey:@"errormsg" ]];
	}
}

//注册
-(void)registerAction{
    [[HMGLTransitionManager sharedTransitionManager] 
     setTransition:[[[FlipTransition alloc] init] autorelease]];
    
    [[HMGLTransitionManager sharedTransitionManager] pushViewController:[kAppDelegate loadFromVC:@"UserRegisterViewController"] onViewController:self];

}

@end
