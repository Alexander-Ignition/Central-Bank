//
//  DetailViewController.h
//  Central Bank
//
//  Created by Александр Игнатьев on 04.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import UIKit;

@class CBCurrency;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) CBCurrency *currency;

+ (NSString *)segueIdentifier;

@end
