//
//  CBHTTPSessionManager.m
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBHTTPSessionManager.h"
#import <AFOnoResponseSerializer/AFOnoResponseSerializer.h>

static NSString * const CBClientURLString = @"http://www.cbr.ru/scripts/";

@interface NSURLSessionConfiguration (CBClient)
+ (NSURLSessionConfiguration *)cb_defaultSessionConfiguration;
@end

@implementation NSURLSessionConfiguration (CBClient)

+ (NSURLSessionConfiguration *)cb_defaultSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 60.f;
    return configuration;
}

@end


@implementation CBHTTPSessionManager

- (instancetype)init {
    NSURL *baseURL = [NSURL URLWithString:CBClientURLString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration cb_defaultSessionConfiguration];
    
    if (self = [super initWithBaseURL:baseURL sessionConfiguration:configuration]) {
        self.responseSerializer = [AFOnoResponseSerializer XMLResponseSerializer];
    }
    return self;
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [super GET:URLString parameters:parameters success:success failure:failure];
}

@end
