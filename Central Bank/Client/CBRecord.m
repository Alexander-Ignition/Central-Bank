//
//  CBRecord.m
//  Central Bank
//
//  Created by Александр Игнатьев on 02.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBRecord.h"
#import "ONOXMLElement+CBClient.h"

#import <Ono/ONOXMLDocument.h>
#import <AIKit/NSDictionary+AIKit.h>

@implementation CBRecord

- (instancetype)initWithXMLElement:(ONOXMLElement *)element {
    
    NSString *value = [element cb_stringForKey:@"Value"];
    NSDate *date = [element cb_dotDate];
    
    if (!value || !date) {
        return nil;
    }
    
    if (self = [super init]) {
        
        _ID      = [element.attributes ai_stringForKey:@"ID"];
        _nominal = [element cb_numberForKey:@"Nominal"];
        _value   = [self numberFromString:value];
        _date    = date;
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@, %@", self.class, self, _value, _date.description];
}

@end
