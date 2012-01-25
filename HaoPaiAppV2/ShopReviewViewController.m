//
//  ShopReviewViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShopReviewViewController.h"
#import "DLStarRatingControl.h"
#import "ShopReviewDataSource.h"
#import "GCPlaceholderTextView.h"
@implementation ShopReviewViewController

-(void)backAction{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)loadView{
    [super loadView];
    _titl.text = @"添加评论";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:TTIMAGE(@"bundle://btn-return.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-30)/2, 50, 30);
	[_navigationHeader addSubview:backButton];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setImage:TTIMAGE(@"bundle://btn-submit.png") forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
	submitButton.frame = CGRectMake((320-60), (44-30)/2, 50, 30);
	[_navigationHeader addSubview:submitButton];
    
    
    self.tableView.frame = CGRectMake(0, 44, 320, 374);
    

    
    UIImageView *_header = [[UIImageView alloc] initWithImage:[TTIMAGE(@"bundle://bean-list-bg.png") 
                                                             stretchableImageWithLeftCapWidth:1 
                                                             topCapHeight:0]];
    
    _header.userInteractionEnabled = YES;
    _header.frame = CGRectMake(0, 0, 320, 58);
    self.tableView.tableHeaderView = _header;
    [_header release];
    
    UILabel *_tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 320, 21)];
    _tip.font = [UIFont systemFontOfSize:12];
    _tip.textColor = RGBCOLOR(153, 153, 153);
    _tip.backgroundColor = [UIColor clearColor];
    _tip.textAlignment = UITextAlignmentCenter;
    _tip.text = @"轻按星形来总体评价";
    [_header addSubview:_tip];
    [_tip release];
    
    DLStarRatingControl *customNumberOfStars = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, 5, 320, 45) andStars:5];
	customNumberOfStars.backgroundColor = [UIColor clearColor];
	customNumberOfStars.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	customNumberOfStars.rating = 3;
	[_header addSubview:customNumberOfStars];
    [customNumberOfStars release];
    
    TTTableTextItem *item1 = [TTTableTextItem itemWithText:@"点击选择服务"];
    
    item1.userInfo = [NSDictionary dictionaryWithObject:[TTStyledText textFromXHTML:@"服务<span class=\"yellowText\"><span class=\"smallText\">*</span></span>"] 
                                                 forKey:@"styleText"];
    
    TTTableTextItem *item2= [TTTableTextItem itemWithText:@"点击选择环境"];
    
    item2.userInfo = [NSDictionary dictionaryWithObject:[TTStyledText textFromXHTML:@"环境<span class=\"yellowText\"><span class=\"smallText\">*</span></span>"] 
                                                 forKey:@"styleText"];
    
    TTTableTextItem *item3 = [TTTableTextItem itemWithText:@"点击选择特色"];
    
    item3.userInfo = [NSDictionary dictionaryWithObject:[TTStyledText textFromXHTML:@"特色<span class=\"yellowText\"><span class=\"smallText\">*</span></span>"] 
                                                 forKey:@"styleText"];
    
    self.dataSource = [ShopReviewDataSource dataSourceWithObjects:item1,item2,item3,nil];
    
    UIControl *_foot = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    _foot.userInteractionEnabled = YES;
    [_foot addTarget:self action:@selector(footTouch) forControlEvents:UIControlEventTouchUpInside];
    UILabel *_perLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 50, 21)];
    _perLabel.font = [UIFont boldSystemFontOfSize:17];
    _perLabel.text = @"人均";
    [_foot addSubview:_perLabel];
    [_perLabel release];
    
    _perField = [[UITextField alloc] initWithFrame:CGRectMake(195, 10, 120, 21)];
    _perField.font = [UIFont systemFontOfSize:16];
    _perField.delegate = self;
    //_perField.textColor = kGryColor;
    _perField.keyboardType = UIKeyboardTypeNumberPad;
    _perField.placeholder = @"点击输入人均";
    [_foot addSubview:_perField];
    [_perField release];
    
    UIView *_line = [[UIView alloc] init];
    _line.backgroundColor = RGBCOLOR(221, 221, 221);
    _line.frame = CGRectMake(0, 43, 320, 0.5);
    [_foot addSubview:_line];
    [_line release];
    
     _reviewText = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(10, 44, 300, 80)];
    _reviewText.delegate = self;
    _reviewText.font = [UIFont systemFontOfSize:16];
    _reviewText.placeholder = @"评论:请输入您对这道美食、这个餐厅的想法和看法。";
    [_foot addSubview:_reviewText];
    [_reviewText release];
    
    UIView *_line2 = [[UIView alloc] init];
    _line2.backgroundColor = RGBCOLOR(221, 221, 221);
    _line2.frame = CGRectMake(0, 130, 320, 0.5);
    [_foot addSubview:_line2];
    [_line2 release];
    
    UILabel *_shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 140, 100, 21)];
    _shareLabel.font = [UIFont boldSystemFontOfSize:17];
    _shareLabel.text = @"同步分享";
    [_foot addSubview:_shareLabel];
    [_shareLabel release];
    
    UIView *_line3 = [[UIView alloc] init];
    _line3.backgroundColor = RGBCOLOR(221, 221, 221);
    _line3.frame = CGRectMake(0, 173, 320, 0.5);
    [_foot addSubview:_line3];
    [_line3 release];
    
    self.tableView.tableFooterView = _foot;
    [_foot release];
    
}

-(void)submitAction{
    
}


-(void)footTouch{
    [_perField resignFirstResponder];
    [_reviewText resignFirstResponder];
    [UIView animateWithDuration:0.275 
                          delay:0.1 
                        options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         self.tableView.frame = CGRectMake(0, 44, 320, 374);
                     } 
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.275 
                          delay:0 
                        options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         self.tableView.frame = CGRectMake(0, -144, 320, 374);
                     } 
                     completion:^(BOOL finished){
                         
                     }];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.275 
                          delay:0 
                        options:(UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseIn)
                     animations:^{
                         self.tableView.frame = CGRectMake(0, -144, 320, 374);
                     } 
                     completion:^(BOOL finished){
                        
                     }];
    return YES;
}

@end
