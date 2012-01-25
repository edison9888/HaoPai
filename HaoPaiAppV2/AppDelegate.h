//
//  AppDelegate.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//
#import "MTStatusBarOverlay.h"
#import "MBProgressHUD.h"
@class TBKTabBarController;
@class FMDatabase;
@interface AppDelegate : NSObject <UIApplicationDelegate,MTStatusBarOverlayDelegate,MBProgressHUDDelegate>{
    TTNavigator* _navigator;
	NSMutableDictionary *_temporaryValues;
	MBProgressHUD *_HUD;
    TBKTabBarController * _tabBarController;
    FMDatabase *_db;
}
@property (nonatomic, readonly) TTNavigator* navigator;
@property (nonatomic, retain) NSMutableDictionary *temporaryValues;
@property (nonatomic, readonly) MBProgressHUD *HUD;
@property (nonatomic, readonly) TBKTabBarController* tabBarController;
@property (nonatomic,readonly) FMDatabase *db;
-(void)alert:(NSString*)title message:(NSString*)message;
-(void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset;
-(void)HUDHide;
- (void)showWithCustomView:(NSString*)labelText;
- (UIViewController*)loadFromNib:(NSString*)className;
- (UIViewController *)loadFromVC:(NSString *)className;
- (void)alert:(NSString*)title message:(NSString*)message;

@end
