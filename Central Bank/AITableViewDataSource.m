//
//  AITableViewDataSource.m
//  Central Bank
//
//  Created by Alexander Ignition on 02.03.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import "AITableViewDataSource.h"

@interface AITableViewDataSource ()

@property (nonatomic, copy) UIView *(^noDataViewForFrame)(CGRect frame);
@property (nonatomic, copy) NSInteger (^numberOfSectionsInTableView)(UITableView *tableView, NSArray *items);
@property (nonatomic, copy) UITableViewCell *(^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^configureCellAtIndexPath)(UITableViewCell *cell, NSIndexPath *indexPath, id item);

@end


@implementation AITableViewDataSource

- (instancetype)initWitthItems:(NSArray *)items {
    if (self = [super init]) {
        _items = items;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.items) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if (self.numberOfSectionsInTableView) {
            return self.numberOfSectionsInTableView(tableView, self.items);
        }
        return 1;
        
    } else {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.noDataViewForFrame) {
            CGRect frame = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(tableView.bounds));
            tableView.backgroundView = self.noDataViewForFrame(frame);
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellForRowAtIndexPath) {
        UITableViewCell *cell = self.cellForRowAtIndexPath(tableView, indexPath);
        
        if (self.configureCellAtIndexPath) {
            self.configureCellAtIndexPath(cell, indexPath, self.items[indexPath.row]);
        }
        return cell;
    }
    return nil;
}

@end
