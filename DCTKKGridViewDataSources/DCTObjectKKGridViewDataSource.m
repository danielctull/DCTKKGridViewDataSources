//
//  DCTObjectKKGridViewDataSource.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTObjectKKGridViewDataSource.h"
#import "KKGridView+DCTKKGridViewDataSources.h"

@implementation DCTObjectKKGridViewDataSource

@synthesize object;

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section {
	return 1;
}

- (id)objectAtIndexPath:(KKIndexPath *)indexPath {
	return self.object;
}

- (void)reloadData {
	KKIndexPath *indexPath = [KKIndexPath indexPathForIndex:0 inSection:0];
	indexPath = [self.gridView dct_convertIndexPath:indexPath fromChildKKGridViewDataSource:self];
	[self.gridView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
}

@end
