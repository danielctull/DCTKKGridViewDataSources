//
//  DCTSplitKKGridViewDataSource.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTSplitKKGridViewDataSource.h"
#import "KKGridView+DCTKKGridViewDataSources.h"

@interface DCTSplitKKGridViewDataSource ()
- (NSMutableArray *)dctInternal_gridViewDataSources;
- (void)dctInternal_setupDataSource:(DCTKKGridViewDataSource *)dataSource;
- (NSArray *)dctInternal_indexPathsForDataSource:(DCTKKGridViewDataSource *)dataSource;
@end

@implementation DCTSplitKKGridViewDataSource {
	__strong NSMutableArray *dctInternal_gridViewDataSources;
	BOOL gridViewHasSetup;
}

@synthesize type;

- (DCTSplitKKGridViewDataSourceType)type {
	return DCTSplitKKGridViewDataSourceTypeIndex;
}

- (NSArray *)childKKGridViewDataSources {
	return [[self dctInternal_gridViewDataSources] copy];
}

- (KKIndexPath *)convertIndexPath:(KKIndexPath *)indexPath fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	
	NSAssert([dctInternal_gridViewDataSources containsObject:dataSource], @"dataSource should be a child table view data source");
	
	NSArray *dataSources = [self dctInternal_gridViewDataSources];
	
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex) {
		
		__block NSUInteger index = indexPath.index;
		
		[dataSources enumerateObjectsUsingBlock:^(DCTKKGridViewDataSource *ds, NSUInteger idx, BOOL *stop) {
			
			if ([ds isEqual:dataSource])
				*stop = YES;
			else
				index += [ds gridView:self.gridView numberOfItemsInSection:0];
			
		}];
		
		indexPath = [KKIndexPath indexPathForIndex:index inSection:0];
		
	} else {
		
		indexPath = [KKIndexPath indexPathForIndex:indexPath.index inSection:[dataSources indexOfObject:dataSource]];
	}
	
	return indexPath;
}

- (NSUInteger)convertSection:(NSUInteger)section fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	
	NSAssert([dctInternal_gridViewDataSources containsObject:dataSource], @"dataSource should be a child table view data source");
	
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex) 
		section = 0;
	else 
		section = [[self dctInternal_gridViewDataSources] indexOfObject:dataSource];
	
	return section;
}

- (KKIndexPath *)convertIndexPath:(KKIndexPath *)indexPath toChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	
	NSAssert([dctInternal_gridViewDataSources containsObject:dataSource], @"dataSource should be a child table view data source");
	
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex) {
		
		__block NSUInteger totalRows = 0;
		NSUInteger index = indexPath.index;
		
		[[self dctInternal_gridViewDataSources] enumerateObjectsUsingBlock:^(DCTKKGridViewDataSource *ds, NSUInteger idx, BOOL *stop) {
			
			NSUInteger numberOfRows = [ds gridView:self.gridView numberOfItemsInSection:0];
			
			if ((totalRows + numberOfRows) > index)
				*stop = YES;
			else
				totalRows += numberOfRows;
		}];
		
		index = indexPath.index - totalRows;
		
		return [KKIndexPath indexPathForIndex:index inSection:0];
	}
	
	return [KKIndexPath indexPathForIndex:indexPath.index inSection:0];
}

- (NSUInteger)convertSection:(NSUInteger)section toChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	NSAssert([dctInternal_gridViewDataSources containsObject:dataSource], @"dataSource should be a child table view data source");
	return 0;
}

- (DCTKKGridViewDataSource *)childKKGridViewDataSourceForSection:(NSUInteger)section {
	
	NSArray *dataSources = [self dctInternal_gridViewDataSources];
	
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex) {
		
		NSAssert([dataSources count] > 0, @"Something's gone wrong.");
		
		return [dataSources objectAtIndex:0];
	}
	
	return [dataSources objectAtIndex:section];
}

- (DCTKKGridViewDataSource *)childKKGridViewDataSourceForIndexPath:(KKIndexPath *)indexPath {
	
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex) {
		
		__block NSInteger totalRows = 0;
		__block DCTKKGridViewDataSource *dataSource = nil;
		NSUInteger index = indexPath.index;
		
		[[self dctInternal_gridViewDataSources] enumerateObjectsUsingBlock:^(DCTKKGridViewDataSource *ds, NSUInteger idx, BOOL *stop) {
			
			NSInteger numberOfRows = [ds gridView:self.gridView numberOfItemsInSection:0];
			
			totalRows += numberOfRows;
			
			if (totalRows > index) {
				dataSource = ds;
				*stop = YES;
			}
		}];
		
		return dataSource;
	}
	
	return [[self dctInternal_gridViewDataSources] objectAtIndex:indexPath.section];
}

- (BOOL)childKKGridViewDataSourceShouldUpdateCells:(DCTKKGridViewDataSource *)dataSource {
	
	if (!self.parent) return YES;
	
	return [self.parent childKKGridViewDataSourceShouldUpdateCells:self];	
}

#pragma mark - DCTSplitKKGridViewDataSource methods

- (void)addChildTableViewDataSource:(DCTKKGridViewDataSource *)gridViewDataSource {
	
	NSMutableArray *childDataSources = [self dctInternal_gridViewDataSources];
	
	[childDataSources addObject:gridViewDataSource];
	
	[self dctInternal_setupDataSource:gridViewDataSource];
	
	if (!gridViewHasSetup) return;
	
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex) {
		
		NSArray *indexPaths = [self dctInternal_indexPathsForDataSource:gridViewDataSource];
		[self.gridView insertItemsAtIndexPaths:indexPaths withAnimation:KKGridViewAnimationFade];
		
	} else {
		/*
		NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[childDataSources indexOfObject:tableViewDataSource]];
		[self.tableView insertSections:indexSet withRowAnimation:FRCTableViewDataSourceTableViewRowAnimationAutomatic];
		 */		
	}
}

- (void)removeChildTableViewDataSource:(DCTKKGridViewDataSource *)gridViewDataSource {
	
	NSAssert([dctInternal_gridViewDataSources containsObject:gridViewDataSource], @"dataSource should be a child table view data source");
	
	NSMutableArray *childDataSources = [self dctInternal_gridViewDataSources];
		
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex) {
		
		NSArray *indexPaths = [self dctInternal_indexPathsForDataSource:gridViewDataSource];
		
		[childDataSources removeObject:gridViewDataSource];
		
		if (!gridViewHasSetup) return;
		
		[self.gridView deleteItemsAtIndexPaths:indexPaths withAnimation:KKGridViewAnimationFade];
		
	} else {
		/*
		NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[childDataSources indexOfObject:tableViewDataSource]];
		
		[childDataSources removeObject:tableViewDataSource];
		
		if (!tableViewHasSetup) return;
		
		[self.gridView redeleteSections:indexSet withRowAnimation:FRCTableViewDataSourceTableViewRowAnimationAutomatic];
		*/
	}
}

#pragma mark - KKGridViewDataSource methods

- (NSUInteger)numberOfSectionsInGridView:(KKGridView *)gv {	
	gridViewHasSetup = YES;
	self.gridView = gv;
	
	if (self.type == DCTSplitKKGridViewDataSourceTypeIndex)
		return 1;
	
	return [[self dctInternal_gridViewDataSources] count];
}

- (NSUInteger)gridView:(KKGridView *)gv numberOfItemsInSection:(NSUInteger)section {
	gridViewHasSetup = YES;
	if (self.type == DCTSplitKKGridViewDataSourceTypeSection)
		return [super gridView:gv numberOfItemsInSection:section];
	
	
	__block NSUInteger numberOfItems = 0;
	
	[[self dctInternal_gridViewDataSources] enumerateObjectsUsingBlock:^(DCTKKGridViewDataSource *ds, NSUInteger idx, BOOL *stop) {
		numberOfItems += [ds gridView:self.gridView numberOfItemsInSection:0];
	}];
	
	return numberOfItems;
}

#pragma mark - Internal methods

- (NSArray *)dctInternal_indexPathsForDataSource:(DCTKKGridViewDataSource *)dataSource {
	
	NSInteger numberOfRows = [dataSource gridView:self.gridView numberOfItemsInSection:0];
	
	NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:numberOfRows];
	
	for (NSInteger i = 0; i < numberOfRows; i++) {
		KKIndexPath *ip = [KKIndexPath indexPathForIndex:i inSection:0];
		ip = [self.gridView dct_convertIndexPath:ip fromChildKKGridViewDataSource:dataSource];
		[indexPaths addObject:ip];
	}
	
	return [indexPaths copy];
}

- (NSMutableArray *)dctInternal_gridViewDataSources {
	
	if (!dctInternal_gridViewDataSources) 
		dctInternal_gridViewDataSources = [[NSMutableArray alloc] init];
	
	return dctInternal_gridViewDataSources;	
}

- (void)dctInternal_setupDataSource:(DCTKKGridViewDataSource *)dataSource {
	dataSource.gridView = self.gridView;
	dataSource.parent = self;
}

@end
