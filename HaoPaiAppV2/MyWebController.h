//
//  MyWebController.h
//  HaoPaiApp
//
//  Created by 高飞 on 11-7-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Three20UI/TTModelViewController.h"

@protocol TTWebControllerDelegate;

@interface MyWebController : TTModelViewController <UIWebViewDelegate, UIActionSheetDelegate> {
@protected
	UIWebView*        _webView;
	
	UIToolbar*        _toolbar;
	
	UIView*           _headerView;
	
	UIBarButtonItem*  _backButton;
	UIBarButtonItem*  _forwardButton;
	UIBarButtonItem*  _refreshButton;
	UIBarButtonItem*  _stopButton;
	UIBarButtonItem*  _actionButton;
	UIBarButtonItem*  _activityItem;
	
	NSURL*            _loadingURL;
	
	UIActionSheet*    _actionSheet;
	
	id<TTWebControllerDelegate> _delegate;
}

/**
 * The current web view URL. If the web view is currently loading a URL, then the loading URL is
 * returned instead.
 */
@property (nonatomic, readonly) NSURL*  URL;

/**
 * A view that is inserted at the top of the web view, within the scroller.
 */
@property (nonatomic, retain)   UIView* headerView;

/**
 * The web controller delegate, currently does nothing.
 */
@property (nonatomic, assign)   id<TTWebControllerDelegate> delegate;

/**
 * Navigate to the given URL.
 */
- (void)openURL:(NSURL*)URL;

/**
 * Load the given request using UIWebView's loadRequest:.
 *
 * @param request  A URL request identifying the location of the content to load.
 */
- (void)openRequest:(NSURLRequest*)request;

@end
