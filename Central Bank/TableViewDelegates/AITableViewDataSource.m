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
@property (nonatomic, copy) UITableViewCell *(^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath, id item);

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
    
    NSInteger count = 0;
    UIView *view;
    if (self.items) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        if (self.numberOfSectionsInTableView) {
            return self.numberOfSectionsInTableView(tableView, self.items);
        }
        view = nil;
        count = 1;
        
    } else {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.noDataViewForFrame) {
            view = self.noDataViewForFrame(tableView.bounds);
        }
    }
    tableView.backgroundView = view;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellForRowAtIndexPath && self.items.count >= indexPath.row) {
        return self.cellForRowAtIndexPath(tableView, indexPath, self.items[indexPath.row]);
    }
    return nil;
}

@end
