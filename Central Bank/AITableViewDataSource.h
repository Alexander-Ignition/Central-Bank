//
//  AITableViewDataSource.h
//  Central Bank
//
//  Created by Alexander Ignition on 02.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

@import UIKit;

@interface AITableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *items;

- (instancetype)initWitthItems:(NSArray *)items;

- (void)setNoDataViewForFrame:(UIView *(^)(CGRect frame))block;
- (void)setNumberOfSectionsInTableView:(NSInteger (^)(UITableView *tableView, NSArray *items))block;
- (void)setCellForRowAtIndexPath:(UITableViewCell *(^)(UITableView *tableView, NSIndexPath *indexPath))block;
- (void)setConfigureCellAtIndexPath:(void (^)(UITableViewCell *cell, NSIndexPath *indexPath, id item))block;

@end
