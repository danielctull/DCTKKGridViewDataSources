//
//  DCTObjectKKGridViewDataSource.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTObjectKKGridViewDataSource.h"

@implementation DCTObjectKKGridViewDataSource

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section {
	return 1;
}

- (id)objectAtIndexPath:(KKIndexPath *)indexPath {
	return self.object;
}

@end
