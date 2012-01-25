//
//  ShopReviewViewController.h
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//  店铺点评
#import "BaseTableViewController.h"
@class GCPlaceholderTextView;
@interface ShopReviewViewController : BaseTableViewController<UITextFieldDelegate,UITextViewDelegate>{
    GCPlaceholderTextView *_reviewText;
    UITextField *_perField;
}

@end
