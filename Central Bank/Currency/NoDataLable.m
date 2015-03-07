//
//  NoDataLable.m
//  Central Bank
//
//  Created by Alexander Ignition on 02.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "NoDataLable.h"

@implementation NoDataLable

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.text = @"No data is currently available.\n\nPlease pull down or click to refresh.";
        self.textColor = [UIColor blackColor];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [self sizeToFit];
    }
    
    return self;
}

@end
