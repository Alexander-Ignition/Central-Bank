//
//  Central_BankTests.m
//  Central BankTests
//
//  Created by Александр Игнатьев on 23.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface Central_BankTests : XCTestCase

@end

@implementation Central_BankTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        NSString *currencyCode = @"EUR";
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:currencyCode];
        NSLog(@"Currency Symbol : %@", [locale displayNameForKey:NSLocaleCurrencySymbol value:currencyCode]);
    }];
}

@end
