//
//  KKGridView+DCTKKGridViewDataSources.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "KKGridView+DCTKKGridViewDataSources.h"
#import "DCTParentKKGridViewDataSource.h"
#import "DCTKKGridViewDataSource.h"

@implementation KKGridView (DCTKKGridViewDataSources)

- (void)dct_logTableViewDataSources {
}

- (NSInteger)dct_convertSection:(NSInteger)section fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	
	DCTParentKKGridViewDataSource *parent = dataSource.parent;
	
	while (parent) {
		section = [parent convertSection:section fromChildKKGridViewDataSource:dataSource];
		dataSource = parent;
		parent = dataSource.parent;
	}
	
	NSAssert(parent == nil, @"Parent should equal nil at this point");
	NSAssert(dataSource == self.dataSource, @"dataSource should now be the tableview's dataSource");
	
	return section;
	
	
}

- (KKIndexPath *)dct_convertIndexPath:(KKIndexPath *)indexPath fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource {
	
	DCTParentKKGridViewDataSource *parent = dataSource.parent;
	
	while (parent) {
		indexPath = [parent convertIndexPath:indexPath fromChildKKGridViewDataSource:dataSource];
		dataSource = parent;
		parent = dataSource.parent;
	}
	
	NSAssert(parent == nil, @"Parent should equal nil at this point");
	NSAssert(dataSource == self.dataSource, @"dataSource should now be the tableview's dataSource");
	
	return indexPath;
	
}


@end
