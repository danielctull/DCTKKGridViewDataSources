//
//  DCTArrayKKGridViewDataSource.m
//  Tweetopolis
//
//  Created by Daniel Tull on 12.03.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import "DCTArrayKKGridViewDataSource.h"
#import "KKGridView+DCTKKGridViewDataSources.h"

@implementation DCTArrayKKGridViewDataSource
@synthesize array;

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section {
	return [self.array count];
}

- (id)objectAtIndexPath:(KKIndexPath *)indexPath {
	return [self.array objectAtIndex:indexPath.index];
}

- (void)reloadData {
	
	NSUInteger count = [self.array count];
	
	NSMutableArray *indexPaths = [[NSMutableArray alloc] initWithCapacity:count];
	
	for (NSUInteger i = 0; i < count; i++) {
		KKIndexPath *indexPath = [KKIndexPath indexPathForIndex:i inSection:0];
		indexPath = [self.gridView dct_convertIndexPath:indexPath fromChildKKGridViewDataSource:self];
		[indexPaths addObject:indexPath];
	}
	
	[self.gridView reloadItemsAtIndexPaths:indexPaths];
}

@end
