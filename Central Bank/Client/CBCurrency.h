//
//  CDCurrency.h
//  Central Bank
//
//  Created by Alexander Ignition on 27.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

#import "CBModel.h"

@interface CBCurrency : CBModel

@property (nonatomic, copy, readonly) NSString *ID;
@property (nonatomic, copy, readonly) NSNumber *numCode;
@property (nonatomic, copy, readonly) NSString *charCode;
@property (nonatomic, copy, readonly) NSNumber *nominal;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSNumber *value;

@property (nonatomic, strong, readonly) NSLocale *locale;
@property (nonatomic, strong, readonly) NSString *symbol;

- (NSString *)localizedNominal;
- (NSString *)localizedValue;

@end
