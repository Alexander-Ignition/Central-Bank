//
//  CBClient.h
//  Central Bank
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//
//  Doc: http://www.cbr.ru/scripts/Root.asp?PrtId=SXML

@import Foundation;

#import <Ono/ONOXMLDocument.h>

#define CB_Client [CBClient sharedClient]

typedef void (^CBClientXMLBlock)(NSURLSessionDataTask *task, ONOXMLDocument *XMLDocument);
typedef void (^CBClientErrorBlock)(NSURLSessionDataTask *task, NSError *error);

@interface CBClient : NSObject

+ (CBClient *)sharedClient;

- (NSURLSessionDataTask *)GETSuccess:(CBClientXMLBlock)success
                             failure:(CBClientErrorBlock)failure;

@end
