//
//  AITableViewDelegate.h
//  Central Bank
//
//  Created by Александр Игнатьев on 03.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import UIKit;

@class AITableViewDataSource;

@interface AITableViewDelegate : NSObject <UITableViewDelegate>

@property (weak, nonatomic) AITableViewDataSource *dataSource;

- (instancetype)initWitthDataSource:(AITableViewDataSource *)dataSource;

- (void)setDidSelectRowAtIndexPath:(void (^)(UITableView *tableView, NSIndexPath *indexPath, id item))block;

@end
