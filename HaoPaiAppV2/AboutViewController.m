//
//  AboutViewController.m
//  HaoPaiAppV2
//
//  Created by 高飞 on 12-1-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutViewDataSource.h"


@implementation AboutViewController

-(void)loadView{
    [super loadView];
    _titl.text = @"关于";
    
    self.tableView.frame = CGRectMake(0, 44, 320, 371);
    self.variableHeightRows = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:TTIMAGE(@"bundle://btn-return.png") forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	backButton.frame = CGRectMake(10, (44-30)/2, 50, 30);
	[_navigationHeader addSubview:backButton];
    
    UIImageView *_header = [[UIImageView alloc] initWithImage:TTIMAGE(@"bundle://pai-info-bg")];
    self.tableView.tableHeaderView = _header;
    [_header release];
    
    self.dataSource = [AboutViewDataSource dataSourceWithObjects:
					   [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:@"<span class=\"largeText\">   好豆网:</span> <span class=\"smallTextAbout\">www.haodou.com</span>" 
																			lineBreaks:YES URLs:YES] URL:nil
                                              accessoryURL:@"http://www.haodou.com"],
					   [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:@"<span class=\"largeText\">   服务热线:</span> <span class=\"smallTextAbout\">4006-770-760</span>" 
																			lineBreaks:YES URLs:YES] URL:nil accessoryURL:@"4006770760"],
					   [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:@"<span class=\"largeText\">   QQ交流群:</span> <span class=\"smallTextAbout\">800077728</span>" 
																			lineBreaks:YES URLs:YES]],
					   nil];
    
}



-(void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (TTIsStringWithAnyText(((TTTableStyledTextItem*)object).accessoryURL)&&
        [((TTTableStyledTextItem*)object).accessoryURL isEqualToString:@"4006770760"]) {
		if (![[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
			
			[kAppDelegate alert:@"" message:@"必须是iPhone才能拨出号码"];
		}else {
			
			NSString *urlPhoneNumber = [NSString stringWithFormat:@"tel://%@",
										((TTTableStyledTextItem*)object).accessoryURL];
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlPhoneNumber]]; 
		}
	}else if(TTIsStringWithAnyText(((TTTableStyledTextItem*)object).accessoryURL)){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((TTTableStyledTextItem*)object).accessoryURL]];
    }
}

@end
