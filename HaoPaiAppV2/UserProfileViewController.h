//
//  UserProfileViewController.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-23.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseMHTabBarController.h"

@interface UserProfileViewController : BaseMHTabBarController{
    UIButton *_cookButon;
    UIButton *_collectButon;
    UIButton *_draftButon;
    TTStyledTextLabel  *_cookLabel;
    TTStyledTextLabel  *_collectLabel;
    TTStyledTextLabel  *_draftLabel;
}

@end
