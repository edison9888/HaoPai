//
//  BaseTableViewController.m
//  LikePath
//
//  Created by 高飞 on 11-5-23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseTableViewController.h"


@implementation BaseTableViewController



-(void)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}



//- (void)showLoading:(BOOL)show {
//    if (show) {
//        if (!self.model.isLoaded || ![self canShowModel]) {
//            NSString* title = _dataSource
//            ? [_dataSource titleForLoading:NO]
//            : [self defaultTitleForLoading];
//            if (title.length) {
//                TTActivityLabel* label =
//                [[[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleGray]
//                 autorelease];
//                label.text = title;
//              //  label.backgroundColor = [UIColor redColor];
//                label.frame = CGRectMake(0, 80, 320, 50);
//                [label sizeToFit];
//                UIImageView  *loadImage = [[[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://cartoon-bg.png")] autorelease];
//                loadImage.contentMode =  UIViewContentModeScaleAspectFill;
//                [loadImage addSubview:label];
//                [loadImage bringSubviewToFront:label];
//                self.loadingView = loadImage;
//            }
//        }
//        
//    } else {
//        self.loadingView = nil;
//    }
//}


-(void) loadView{
	[super loadView];
    _navigationHeader = [[UIImageView alloc] 
                         initWithImage:[TTIMAGE(@"bundle://menu-top-bg.png")
                                        stretchableImageWithLeftCapWidth:1
                                        topCapHeight:44]];
    //_navigationHeader.backgroundColor = RGBCOLOR(94, 138, 0);
    [_navigationHeader setUserInteractionEnabled:YES];
    _navigationHeader.frame = CGRectMake(0, 0, 320, 44);
    [self.view addSubview:_navigationHeader];
    [_navigationHeader release];
    
    _titl = [[UILabel alloc] init];
	_titl.font = [UIFont boldSystemFontOfSize:20];
	_titl.textColor = [UIColor whiteColor];
    
	_titl.shadowColor = [UIColor grayColor];
    _titl.shadowOffset = CGSizeMake(0, -1.0);
	_titl.textAlignment = UITextAlignmentCenter;
	_titl.frame = CGRectMake(70, (44-20)/2, 180, 20);
	
	_titl.backgroundColor = [UIColor clearColor];
	[_navigationHeader addSubview:_titl];
	[_titl release];
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

@end
