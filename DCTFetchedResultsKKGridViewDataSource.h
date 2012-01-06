//
//  KKGridViewDataSource.h
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTKKGridViewDataSource.h"

@interface DCTFetchedResultsKKGridViewDataSource : DCTKKGridViewDataSource
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end
