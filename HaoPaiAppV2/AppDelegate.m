//
//  AppDelegate.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 11-12-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchImageTransition.h"
#import "Reachability.h"
#import "TBKTabBarController.h"
#import "FMDatabase.h"
#import "iRate.h"
@interface MyStyleSheet : TTDefaultStyleSheet
@end

@implementation MyStyleSheet

- (TTStyle*)largeText {
	return [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:17] next:nil];
}

- (TTStyle*)smallTextAbout {
	return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:17] next:nil];
}

- (TTStyle*)yellowText {
	return [TTTextStyle styleWithColor:RGBCOLOR(240, 144, 0) next:nil];
}

- (TTStyle*)blackText {
	return [TTTextStyle styleWithColor:[UIColor blackColor] next:nil];
}

- (TTStyle*)smallText {
	return [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:14] next:nil];
}

@end

@implementation AppDelegate
@synthesize temporaryValues = _temporaryValues;

static UIAlertView *sAlert = nil;

-(void) dealloc{
	[TTStyleSheet setGlobalStyleSheet:nil];
    [_db close];
	TT_RELEASE_SAFELY(_db);
	TT_RELEASE_SAFELY(_temporaryValues);
    TT_RELEASE_SAFELY(_tabBarController);
	[super dealloc];
}

+ (void)initialize
{
	//configure iRate
	[iRate sharedInstance].appStoreID = 465278695;
	[iRate sharedInstance].debug = NO;
	[iRate sharedInstance].applicationName = @"好豆好拍";
	[iRate sharedInstance].messageTitle = @"";
	[iRate sharedInstance].remindPeriod = 2;
	[iRate sharedInstance].message = @"亲,您的好评或建议会使好豆好拍越来越好用.";
	[iRate sharedInstance].rateButtonLabel = @"马上评星";
	[iRate sharedInstance].remindButtonLabel = @"稍后评价";
	[iRate sharedInstance].cancelButtonLabel = @"谢谢不再提醒";
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    NSMutableDictionary *tDic = [[NSMutableDictionary alloc] init];
	self.temporaryValues = tDic;
	[tDic release];
    
    [TTStyleSheet setGlobalStyleSheet:[[[MyStyleSheet alloc] init] autorelease]];
	TTURLMap* map = self.navigator.URLMap;
  	[map from:@"tt://nib/(loadFromNib:)" toSharedViewController:self];
	[map from:@"tt://tabBar/(loadTarBar:)" toSharedViewController:self];
	[map from:@"tt://nib/(loadFromNib:)/(withClass:)" toSharedViewController:self];
	[map from:@"tt://viewController/(loadFromVC:)" toSharedViewController:self];
	[map from:@"tt://modal/viewController/(loadFromVC:)" toModalViewController:self];
	[map from:@"tt://modal/(loadFromNib:)" toModalViewController:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:@"长沙" forKey:@"UserCity"];
	[defaults setObject:@"127" forKey:@"city_id"];
	[defaults synchronize];
    
    if (![self.navigator restoreViewControllers]) {
		[self.navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://viewController/LaunchImageTransition"]];
	}
    
//    MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
//    overlay.animation = MTStatusBarOverlayAnimationFallDown;  // MTStatusBarOverlayAnimationShrink
//    overlay.detailViewMode = MTDetailViewModeHistory;// enable automatic history-tracking and show in detail-view
//    overlay.delegate = self;
//    overlay.progress = 0.0;
//    [overlay postMessage:@"Following @myell0w on Twitter…"];
//    overlay.progress = 0.1;
//    // ...
//    [overlay postMessage:@"Following myell0w on Github…" animated:NO];
//    overlay.progress = 0.5;
//    // ...
//    [overlay postImmediateFinishMessage:@"Following was a good idea!" duration:2.0 animated:YES];
//    overlay.progress = 1.0;
}

-(void)statusBarOverlayDidRecognizeGesture:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"touch");
}

//城市数据库
-(id)db{
	if (!_db) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]
								   stringByAppendingPathComponent:kDataBase];
		_db = [[FMDatabase alloc] initWithPath:defaultDBPath];
		if ([_db open]) {
			[_db setShouldCacheStatements:YES];
		}
	}
	return _db;
}

-(TBKTabBarController*) tabBarController{
	if (!_tabBarController) {
		_tabBarController = [[TBKTabBarController alloc] initWithStyle:TBKTabBarStyleDefault];
	}
	return _tabBarController;
}

-(TTNavigator*)navigator{
	if (!_navigator) {
		_navigator = [TTNavigator navigator];
		_navigator.persistenceMode = TTNavigatorPersistenceModeNone;
		_navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
	}
	return _navigator;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the nib
 */
- (UIViewController*)loadFromNib:(NSString *)nibName withClass:className {
	UIViewController* newController = [[NSClassFromString(className) alloc]
									   initWithNibName:nibName bundle:nil];
	[newController autorelease];
	
	return newController;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller from the the nib with the same name as the
 * class
 */
- (UIViewController*)loadFromNib:(NSString*)className {
	return [self loadFromNib:className withClass:className];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Loads the given viewcontroller by name
 */
- (UIViewController *)loadFromVC:(NSString *)className {
	UIViewController * newController = [[ NSClassFromString(className) alloc] init];
	[newController autorelease];
	return newController;
}

#pragma mark  Common utilities
// 是否wifi
+ (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

// 是否3G
+ (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}



- (void)alert:(NSString*)title message:(NSString*)message
{
    if (sAlert) return;
    
    sAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(title,@"")
                                        message:NSLocalizedString(message,@"")
									   delegate:self
							  cancelButtonTitle:@"关闭"
							  otherButtonTitles:nil];
    [sAlert show];
    [sAlert release];
	sAlert = nil;
}

-(MBProgressHUD *) HUD{
	if (!_HUD) {
		_HUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
		_HUD.animationType = MBProgressHUDAnimationZoom;
		_HUD.delegate = self;
		[[[UIApplication sharedApplication] keyWindow] addSubview:_HUD];
	}
	return _HUD;
}

-(void)HUDShow:(NSString*)labelText yOffset:(NSString*)yOffset{
	TT_RELEASE_SAFELY(_HUD);
	self.HUD.labelText = labelText;
	self.HUD.yOffset = [yOffset floatValue];
	[self.HUD show:YES];
}

-(void)HUDHide{
	[self.HUD hide:YES];
	[self.HUD performSelector:@selector(setMode:)
				   withObject:MBProgressHUDModeIndeterminate
				   afterDelay:0.5];
}


- (void)showWithCustomView:(NSString*)labelText {
	TT_RELEASE_SAFELY(_HUD);
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	self.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
	
    // Set custom view mode
    self.HUD.mode = MBProgressHUDModeCustomView;
	self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.labelText = labelText;
	
    [self.HUD show:YES];
	[self.HUD hide:YES afterDelay:0.7];
	[self.HUD performSelector:@selector(setMode:)
				   withObject:MBProgressHUDModeIndeterminate
				   afterDelay:0.8];
}

- (void)showWithTextView:(NSString *)labelText {
    TT_RELEASE_SAFELY(_HUD);
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	self.HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkMarkLogo.png"]] autorelease];
	
    // Set custom view mode
    self.HUD.mode = MBProgressHUDModeCustomView;
	self.HUD.animationType = MBProgressHUDAnimationZoom;
    self.HUD.labelText = labelText;
    self.HUD.detailsLabelText = @"或者邮箱地址,方便联系,谢谢!";
    self.HUD.labelFont = [UIFont systemFontOfSize:13];
	self.HUD.yOffset = -90;
    
    [self.HUD show:YES];
	[self.HUD hide:YES afterDelay:2.5];
	[self.HUD performSelector:@selector(setMode:)
				   withObject:MBProgressHUDModeIndeterminate
				   afterDelay:2.6];
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [_HUD removeFromSuperview];
    TT_RELEASE_SAFELY(_HUD);
}

@end
