//
//  QVerifyWebViewController.h
//  QWeiboSDK4iOSDemo
//
//  Created   on 11-1-14.
//   
//

#import <UIKit/UIKit.h>


@interface QVerifyWebViewController : UIViewController<UIWebViewDelegate> {
	UIWebView *mWebView;
	UIImageView *_navigationHeader;
}
@property (nonatomic, readonly) IBOutlet UIImageView *navigationHeader;

@end
