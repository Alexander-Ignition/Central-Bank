//
//  CBClient.m
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBClient.h"
#import "CBHTTPSessionManager.h"
#import "ONOXMLElement+CBClient.h"

@interface CBClient ()
@property (strong, nonatomic) CBHTTPSessionManager *sessionManager;
@end


@implementation CBClient

+ (CBClient *)sharedClient {
    static id client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [self new];
    });
    return client;
}

#pragma mark - AFHTTPSessionManager

- (CBHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [CBHTTPSessionManager new];
    }
    return _sessionManager;
}

- (NSURLSessionDataTask *)currency:(void (^)(NSURLSessionDataTask *task, NSArray *currencies, NSDate *date))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [self.sessionManager GET:nil parameters:nil success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        
        if (success) {
            success(task, [CBCurrency currenciesFromXML:XMLDocument], [XMLDocument.rootElement cb_date]);
        }
        
    } failure:failure];
}

@end
