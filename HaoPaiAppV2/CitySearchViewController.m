//
//  CitySearchViewControlller.m
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-9.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CitySearchViewController.h"
#import <Three20UICommon/UIViewControllerAdditions.h>

@implementation CitySearchViewController

-(void) didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
	[self.superController typeSelect:object];
}

@end
