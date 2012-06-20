//
//  DCTKKGridViewDataSource.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTKKGridViewDataSource.h"
#import "DCTKKGridViewCell.h"

@implementation DCTKKGridViewDataSource

@synthesize gridView;
@synthesize cellClass;
@synthesize parent;

#pragma mark - NSObject

- (void)dealloc {
	dct_nil(self.parent);
}

- (id)init {
    
    if (!(self = [super init])) return nil;
	
	self.cellClass = [DCTKKGridViewCell class];
	
    return self;
}

#pragma mark - DCTKKGridViewDataSource

- (void)reloadData {}

- (id)objectAtIndexPath:(KKIndexPath *)indexPath {
	return indexPath;
}

- (Class)cellClassAtIndexPath:(KKIndexPath *)indexPath {
	return [self cellClass];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - KKGridViewDataSource

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section {
	return 5;
}

- (KKGridViewCell *)gridView:(KKGridView *)gv cellForItemAtIndexPath:(KKIndexPath *)indexPath {
		
	Class theCellClass = [self cellClassAtIndexPath:indexPath];
	
	KKGridViewCell *cell = [theCellClass cellForGridView:gv];
	
	if ([cell conformsToProtocol:@protocol(DCTKKGridViewCellObjectConfiguration)])
		[(id<DCTKKGridViewCellObjectConfiguration>)cell configureWithObject:[self objectAtIndexPath:indexPath]];
	
	return cell;
}

@end
