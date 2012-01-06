//
//  DCTParentKKGridViewDataSource.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTParentKKGridViewDataSource.h"

@implementation DCTParentKKGridViewDataSource

#pragma mark - DCTKKGridViewDataSource

- (void)reloadData {
	for (DCTKKGridViewDataSource * ds in self.childKKGridViewDataSources)
		[ds reloadData];
}

- (id)objectAtIndexPath:(KKIndexPath *)indexPath {
	DCTKKGridViewDataSource * ds = [self childKKGridViewDataSourceForIndexPath:indexPath];
	indexPath = [self convertIndexPath:indexPath toChildKKGridViewDataSource:ds];
	return [ds objectAtIndexPath:indexPath];
}

- (Class)cellClassAtIndexPath:(KKIndexPath *)indexPath {
	DCTKKGridViewDataSource * ds = [self childKKGridViewDataSourceForIndexPath:indexPath];
	indexPath = [self convertIndexPath:indexPath toChildKKGridViewDataSource:ds];
	return [ds cellClassAtIndexPath:indexPath];
}

- (void)setGridView:(KKGridView *)gv {
	
	if (gv == self.gridView) return;
	
	[super setGridView:gv];
	
	[self.childKKGridViewDataSources enumerateObjectsUsingBlock:^(DCTKKGridViewDataSource * ds, NSUInteger idx, BOOL *stop) {
		ds.gridView = self.gridView;
	}];
}

#pragma mark - FRCParentTableViewDataSource

- (NSArray *)childKKGridViewDataSources {
	return nil;
}

- (KKIndexPath *)convertIndexPath:(KKIndexPath *)indexPath fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	NSAssert([self.childKKGridViewDataSources containsObject:dataSource], @"dataSource should be in the childTableViewDataSources");
	return indexPath;
}

- (KKIndexPath *)convertIndexPath:(KKIndexPath *)indexPath toChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {	
	NSAssert([self.childKKGridViewDataSources containsObject:dataSource], @"dataSource should be in the childTableViewDataSources");
	return indexPath;
}

- (NSInteger)convertSection:(NSInteger)section fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	NSAssert([self.childKKGridViewDataSources containsObject:dataSource], @"dataSource should be in the childTableViewDataSources");
	return section;
}

- (NSInteger)convertSection:(NSInteger)section toChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	NSAssert([self.childKKGridViewDataSources containsObject:dataSource], @"dataSource should be in the childTableViewDataSources");
	return section;
}

- (DCTKKGridViewDataSource *)childKKGridViewDataSourceForSection:(NSInteger)section {
	return [self.childKKGridViewDataSources lastObject];
}

- (DCTKKGridViewDataSource *)childKKGridViewDataSourceForIndexPath:(KKIndexPath *)indexPath {
	return [self.childKKGridViewDataSources lastObject];
}

- (BOOL)childKKGridViewDataSourceShouldUpdateCells:(DCTKKGridViewDataSource *)dataSource {
	return NO;
}

@end
