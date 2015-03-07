//
//  NSDateFormatter+CBClient.h
//  Central Bank
//
//  Created by Александр Игнатьев on 28.02.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import Foundation;

@interface NSDateFormatter (CBClient)

+ (instancetype)cb_dotDateFormatter;
+ (instancetype)cb_slashDateFormatter;
+ (instancetype)cb_dateFormatter;

@end
