//
//  ToolUntil.m
//  Cookbook
//
//  Created by 高飞 on 11-8-31.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToolUntil.h"
#import <extThree20JSON/extThree20JSON.h>
#include <unistd.h>
#include <netdb.h>
#include <arpa/inet.h>

@implementation ToolUntil

+(TTURLRequest *) ttURLRequestCreate:(id)delegate 
						 cachePolicy:(TTURLRequestCachePolicy)cachePolicy 
								 url:(NSString *)url
							method:(NSString*)method{
	TTURLRequest* request = [TTURLRequest
							 requestWithURL:url
							 delegate:delegate];
	request.httpMethod = method;
	request.cachePolicy = cachePolicy;
	request.cacheExpirationAge = TT_DEFAULT_CACHE_INVALIDATION_AGE;
	TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	return request;
}

+(TTURLRequest *) ttURLRequestCreateNoCache:(id)delegate 
						 cachePolicy:(TTURLRequestCachePolicy)cachePolicy 
								 url:(NSString *)url
                              method:(NSString*)method{
	TTURLRequest* request = [TTURLRequest
							 requestWithURL:url
							 delegate:delegate];
	request.httpMethod = method;
	request.cachePolicy = cachePolicy;
	request.cacheExpirationAge = TT_CACHE_EXPIRATION_AGE_NEVER;
	TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
	return request;
}


+ (NSString*)encodeURL:(NSString *)string
{
	NSString *newString = NSMakeCollectable([(NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) autorelease]);
	if (newString) {
		return newString;
	}
	return @"";
}

+(NSString *)getIpAddress{
    
    NSString *ipAddress;
    char baseHostName[255];
    
    gethostname(baseHostName, 255); // 获得本机名字
    struct hostent *host = gethostbyname(baseHostName); // 将本机名字转换成主机网络结构体 struct hostent
    
    if (host == NULL) {
        herror("resolv");
    } else {
        struct in_addr **list = (struct in_addr **)host->h_addr_list;
        char ip[255];        
        strcpy(ip, inet_ntoa(*list[0])); // 获得本机IP地址    
        ipAddress = [[[NSString alloc] initWithCString:ip] autorelease];    
    }
    
    return ipAddress;
}

+ (NSString*)getDeviceVersion
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

@end
