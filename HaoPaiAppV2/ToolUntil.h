//
//  ToolUntil.h
//  Cookbook
//
//  Created by 高飞 on 11-8-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



@interface ToolUntil : NSObject {

}
+(TTURLRequest*)ttURLRequestCreate:(id)delegate 
					   cachePolicy:(TTURLRequestCachePolicy)cachePolicy 
							   url:(NSString*)url 
							method:(NSString*)method;
+(TTURLRequest *) ttURLRequestCreateNoCache:(id)delegate 
                                cachePolicy:(TTURLRequestCachePolicy)cachePolicy 
                                        url:(NSString *)url
                                     method:(NSString*)method;
+ (NSString*)encodeURL:(NSString *)string;
+ (NSString *)getIpAddress;
+ (NSString*)getDeviceVersion;
@end

