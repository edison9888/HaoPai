//
//  LoginViewController.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//  登陆界面

@interface UserLoginViewController : UIViewController<UITextFieldDelegate>{
    UIImageView *_pic;
    UIView *_container;
    UITextField *_nameField;
    UITextField *_passField;
    id *_superController;
}

@end
