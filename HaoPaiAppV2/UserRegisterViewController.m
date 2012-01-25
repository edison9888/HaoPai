//
//  RegisterViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "NSStringAdditions.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "HMGLTransitionManager.h"
#import "FlipTransition.h"
@implementation UserRegisterViewController

- (void)loadView {
	[super loadView];
    titl.text = @"注 册";
}

-(void)backAction{
    [self.nameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.aliasField resignFirstResponder];
    FlipTransition *flip =[[[FlipTransition alloc] init] autorelease];
    flip.transitionType = FlipTransitionRight;
    [[HMGLTransitionManager sharedTransitionManager] 
     setTransition:flip];
	[[HMGLTransitionManager sharedTransitionManager] popViewController:self];
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
    
    if (!TTIsStringWithAnyText(self.aliasField.text)) {
        [kAppDelegate alert:@"" message:@"请输入您的别名"];
        return;
    }
    
    [kAppDelegate HUDShow:@"注册中" yOffset:0];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kRESTBaseUrl,@"passport.reg"]];
    ASIFormDataRequest * request = [ASIFormDataRequest requestWithURL:url];
    //NSLog(@"email %@ %@",self.nameField.text,self.aliasField.text);
    [request setPostValue:self.nameField.text forKey:@"email" ];
    [request setPostValue:self.aliasField.text forKey:@"username"];
    [request setPostValue:self.passwordField.text forKey:@"pwd"];
    [request setPostValue:self.passwordField.text forKey:@"verify_pwd"];
    
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
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"username" ] 
					 forKey:@"username" ];
		[defaults setObject:[[data objectForKey:@"result"]objectForKey:@"avatar" ] 
					 forKey:@"useravatar" ];
		
		[defaults synchronize];
        
        [self.nameField resignFirstResponder];
        [self.passwordField resignFirstResponder];
        [self.aliasField resignFirstResponder];
        
        FlipTransition *flip =[[[FlipTransition alloc] init] autorelease];
        flip.transitionType = FlipTransitionRight;
        [[HMGLTransitionManager sharedTransitionManager] 
         setTransition:flip];
        [[HMGLTransitionManager sharedTransitionManager] popToRootViewController:self];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogin" object:nil];
        
	}else {
		[kAppDelegate alert:@"" message:[[data objectForKey:@"result"]objectForKey:@"errormsg" ]];
	}
}

@end
