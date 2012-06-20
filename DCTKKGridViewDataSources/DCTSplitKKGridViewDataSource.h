//
//  DCTSplitKKGridViewDataSource.h
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTParentKKGridViewDataSource.h"

typedef enum {
	DCTSplitKKGridViewDataSourceTypeIndex = 0,
	DCTSplitKKGridViewDataSourceTypeSection // NOT AVAILABLE YET
} DCTSplitKKGridViewDataSourceType;

@interface DCTSplitKKGridViewDataSource : DCTParentKKGridViewDataSource

- (void)addChildTableViewDataSource:(DCTKKGridViewDataSource *)dataSource;
- (void)removeChildTableViewDataSource:(DCTKKGridViewDataSource *)dataSource;

@property (nonatomic, assign) DCTSplitKKGridViewDataSourceType type;

@end
