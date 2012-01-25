//
//  DishSearchModel.h
//  HaoPaiApp
//
//  Created by 高飞 on 11-6-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseModel.h"
@class ASIFormDataRequest;

@interface DishSearchModel : BaseModel {
	ASIFormDataRequest *asiRequest;
}
@property (nonatomic, retain) ASIFormDataRequest *asiRequest;
- (void)search:(NSString*)text;
@end
