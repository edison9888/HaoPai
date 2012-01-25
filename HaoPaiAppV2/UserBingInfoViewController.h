//
//  UserBingInfoViewController.h
//  cookbook
//
//  Created by 高飞 on 11-11-28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  绑定信息输入

@interface UserBingInfoViewController : TTViewController{
    UIImageView *_navigationHeader;
    UITextField *_nameField;
	UITextField *_passwordField;
	UITextField *_aliasField;
	UIButton *_actionButton;
	UIImageView *_backFrame;
    UILabel *titl;
}
@property (nonatomic, readonly) IBOutlet UIView *navigationHeader;
@property (nonatomic, readonly) IBOutlet UITextField *nameField;
@property (nonatomic, readonly) IBOutlet UITextField *passwordField;
@property (nonatomic, readonly) IBOutlet UITextField *aliasField;
@property (nonatomic, readonly) IBOutlet UIButton *actionButton;
@property (nonatomic, readonly) IBOutlet UIImageView *backFrame;
@end
