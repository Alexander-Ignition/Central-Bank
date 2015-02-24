//
//  CBClient.m
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBClient.h"

#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFOnoResponseSerializer/AFOnoResponseSerializer.h>

static NSString * const CBClientURLString = @"http://www.cbr.ru/scripts/";

@interface CBClient ()
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@end


@implementation CBClient

+ (CBClient *)sharedClient
{
    static id client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [self new];
    });
    return client;
}

#pragma mark - AFHTTPSessionManager

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        NSURL *baseURL = [NSURL URLWithString:CBClientURLString];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = 60.f;
        
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        _sessionManager.responseSerializer = [AFOnoResponseSerializer XMLResponseSerializer];
    }
    return _sessionManager;
}

- (NSURLSessionDataTask *)GETSuccess:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.sessionManager GET:@"XML_daily.asp" parameters:nil success:success failure:failure];
}


@end
