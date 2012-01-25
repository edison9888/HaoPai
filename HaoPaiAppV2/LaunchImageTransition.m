//
//  LaunchImageTransition.m
//  Created by http://github.com/iosdeveloper
//

#import "LaunchImageTransition.h"
#import "FlipTransition.h"
#import "HMGLTransitionManager.h"
#import "TBKTabBarController.h"
@implementation LaunchImageTransition



-(id)init{
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userLogin) name:@"userLogin" 
                                                   object:nil];
        
        [self performSelector:@selector(timerFireMethod:) withObject:nil afterDelay:0.0];
    }
    return self;
}

-(void)loadView{
    [super loadView];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *launchImageFile = [infoDictionary objectForKey:@"UILaunchImageFile"];
    
    NSString *launchImageFileiPhone = [infoDictionary objectForKey:@"UILaunchImageFile~iphone"];
    
    if (launchImageFile != nil) {
        [self.view addSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImageFile]] autorelease]];
    } else if (launchImageFileiPhone != nil) {
        [self.view addSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImageFileiPhone]] autorelease]];
    } else {
        [self.view addSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]] autorelease]];
    }
    UIActivityIndicatorView *_indicator = [[UIActivityIndicatorView alloc] 
                                           initWithFrame:CGRectMake(215, 195, 32, 32)];
    [_indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_indicator];
    [_indicator startAnimating];
    [_indicator release];
}

-(void)userLogin{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self performSelector:@selector(timerFireMethod:) withObject:nil afterDelay:1];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)timerFireMethod:(NSTimer *)theTimer {
    [[HMGLTransitionManager sharedTransitionManager] 
     setTransition:[[[FlipTransition alloc] init] autorelease]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (TTIsStringWithAnyText([defaults objectForKey:@"sessionkey"])) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [[HMGLTransitionManager sharedTransitionManager] pushViewController:kAppDelegate.tabBarController 
                                                           onViewController:self];
    }else{
        [[HMGLTransitionManager sharedTransitionManager] pushViewController:
         [kAppDelegate loadFromVC:@"UserLoginViewController"] 
                                                           onViewController:self];
    }
}



@end