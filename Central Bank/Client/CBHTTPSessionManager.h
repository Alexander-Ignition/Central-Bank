//
//  CBHTTPSessionManager.h
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <Ono/ONOXMLDocument.h>
#import <AFNetworking/AFHTTPSessionManager.h>

@interface CBHTTPSessionManager : AFHTTPSessionManager

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
