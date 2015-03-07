//
//  CurrencyCell.h
//  Central Bank
//
//  Created by Александр Игнатьев on 07.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import UIKit;

@class CBCurrency;

@interface CurrencyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *nominal;
@property (weak, nonatomic) IBOutlet UILabel *value;

@end
