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

- (instancetype)initWithXMLElement:(ONOXMLElement *)element {
    
    NSString *ID       = [element.attributes ai_stringForKey:@"ID"];
    NSString *charCode = [element cb_stringForKey:@"CharCode"];
    NSString *name     = [element cb_stringForKey:@"Name"];
    NSString *value    = [element cb_stringForKey:@"Value"];
    
    if (!ID || !name || !value) {
        return nil;
    }
    
    if (self = [super init]) {
        
        _ID       = ID;
        _numCode  = [element cb_numberForKey:@"NumCode"];
        _charCode = charCode;
        _nominal  = [element cb_numberForKey:@"Nominal"];
        _name     = name;
        _value    = [self numberFromString:value];
        
        _locale   = [NSLocale localeWithLocaleIdentifier:charCode];
        _symbol   = [_locale displayNameForKey:NSLocaleCurrencySymbol value:charCode];
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> %@ = %@", self.class, self, _name, _value];
}

#pragma mark - NSNumberFormatter

- (NSString *)localizedNominal {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    numberFormatter.currencyCode = self.charCode;
    return [numberFormatter stringFromNumber:self.nominal];
}

- (NSString *)localizedValue {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    numberFormatter.currencyCode = @"RUB";
    return [numberFormatter stringFromNumber:self.value];
}

@end
