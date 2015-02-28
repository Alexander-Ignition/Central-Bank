//
//  ONOXMLElement+CBClient.m
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "ONOXMLElement+CBClient.h"
#import "NSDateFormatter+CBClient.h"
#import <AIKit/NSDictionary+AIKit.h>

@implementation ONOXMLElement (CBClient)

- (NSString *)cb_stringForKey:(NSString *)key {
    return [[self firstChildWithTag:key] stringValue];
}

- (NSNumber *)cb_numberForKey:(NSString *)key {
    return [[self firstChildWithTag:key] numberValue];
}

- (NSDate *)cb_date {
    NSString *dateString = [self.attributes ai_stringForKey:@"Date"];
    return [[NSDateFormatter cb_dateFormatter] dateFromString:dateString];
}

@end
