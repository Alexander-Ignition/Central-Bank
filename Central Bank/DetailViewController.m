//
//  DetailViewController.m
//  Central Bank
//
//  Created by Александр Игнатьев on 04.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "DetailViewController.h"
#import "CBClient.h"

@implementation DetailViewController

+ (NSString *)segueIdentifier {
    return [NSString stringWithFormat:@"%@Segue", NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.currency.name;
    self.navigationItem.prompt = self.currency.value.stringValue;
}

@end
