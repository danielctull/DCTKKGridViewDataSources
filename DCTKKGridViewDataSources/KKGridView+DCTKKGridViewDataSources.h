//
//  KKGridView+DCTKKGridViewDataSources.h
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>
@class DCTKKGridViewDataSource;

@interface KKGridView (DCTKKGridViewDataSources)

/** @name Logging */

- (void)dct_logTableViewDataSources;

/** @name Conversion methods */

- (NSInteger)dct_convertSection:(NSInteger)section fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource;
- (KKIndexPath *)dct_convertIndexPath:(KKIndexPath *)indexPath fromChildKKGridViewDataSource:(DCTKKGridViewDataSource *)dataSource;

@end
