//
//  CDCurrency.m
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "CBCurrency.h"
#import "ONOXMLElement+CBClient.h"

#import <AIKit/NSDictionary+AIKit.h>
#import <Ono/ONOXMLDocument.h>


@implementation CBCurrency

+ (NSArray *)currenciesFromXML:(ONOXMLDocument *)XMLDocument
{
    NSArray *elements = XMLDocument.rootElement.children;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:elements.count];
    
    for (ONOXMLElement *element in elements) {
        CBCurrency *currency = [[self alloc] initWithXMLElement:element];
        
        if (currency) {
            [array addObject:currency];
        }        
    }
    return array;
}

- (instancetype)initWithXMLElement:(ONOXMLElement *)element {
    
    NSString *ID    = [element.attributes ai_stringForKey:@"ID"];
    NSString *name  = [element cb_stringForKey:@"Name"];
    NSString *value = [element cb_stringForKey:@"Value"];
    
    if (!ID || !name || !value) {
        return nil;
    }
    
    if (self = [super init]) {
        
        _ID      = ID;
        _numCode = [element cb_numberForKey:@"NumCode"];
        _strCode = [element cb_stringForKey:@"CharCode"];
        _nominal = [element cb_numberForKey:@"Nominal"];
        _name    = value;
        _value   = name;
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@ = %@", self.class, self, _name, _value];
}

- (NSLocale *)locale {
    return [[NSLocale alloc] initWithLocaleIdentifier:self.strCode];
}

- (NSString *)symbol {
    return [self.locale displayNameForKey:NSLocaleCurrencySymbol value:self.strCode];
}

@end
