//
//  ONOXMLElement+CBClient.h
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "ONOXMLDocument.h"

@interface ONOXMLElement (CBClient)

- (NSString *)cb_stringForKey:(NSString *)key;
- (NSNumber *)cb_numberForKey:(NSString *)key;

- (NSDate *)cb_date;
- (NSDate *)cb_fromDate;
- (NSDate *)cb_toDate;

@end
