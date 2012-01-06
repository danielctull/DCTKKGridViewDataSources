//
//  DCTParentKKGridViewDataSource.h
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTKKGridViewDataSource.h"

@interface DCTParentKKGridViewDataSource : DCTKKGridViewDataSource

/// @name Conversion

- (NSInteger)convertSection:(NSInteger)section fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource;
- (NSInteger)convertSection:(NSInteger)section toChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource;

- (KKIndexPath *)convertIndexPath:(KKIndexPath *)indexPath fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource;
- (KKIndexPath *)convertIndexPath:(KKIndexPath *)indexPath toChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource;

/// @name Retrieving child data sources

@property (nonatomic, readonly) NSArray *childKKGridViewDataSources;
- (DCTKKGridViewDataSource *)childKKGridViewDataSourceForSection:(NSInteger)section;
- (DCTKKGridViewDataSource *)childKKGridViewDataSourceForIndexPath:(KKIndexPath *)indexPath;

/// @name Parental guidance

- (BOOL)childKKGridViewDataSourceShouldUpdateCells:(DCTKKGridViewDataSource *)dataSource;

@end
