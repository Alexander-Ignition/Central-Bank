//
//  CBClient.h
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//
//  Doc: http://www.cbr.ru/scripts/Root.asp?PrtId=SXML

@import Foundation;

#import "CBCurrency.h"

#define CB_Client [CBClient sharedClient]

@interface CBClient : NSObject

+ (CBClient *)sharedClient;

- (NSURLSessionDataTask *)currency:(void (^)(NSURLSessionDataTask *task, NSArray *currencies))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
