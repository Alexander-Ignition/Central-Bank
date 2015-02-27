//
//  CBClient.m
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBClient.h"
#import "CBHTTPSessionManager.h"

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

- (NSURLSessionDataTask *)currency:(void (^)(NSURLSessionDataTask *task, NSArray *currencies))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    __weak __typeof(self)weakSelf = self;
    return [self.sessionManager GET:nil parameters:nil success:^(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument) {
        
        if (success) {
            success(task, [weakSelf currenciesFromXML:XMLDocument]);
        }
        
    } failure:failure];
}

- (NSArray *)currenciesFromXML:(ONOXMLDocument *)XMLDocument
{
    NSArray *elements = XMLDocument.rootElement.children;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:elements.count];
    
    for (ONOXMLElement *element in elements) {
        [array addObject:[[CBCurrency alloc] initWithXMLElement:element]];
    }
    return array;
}

@end
