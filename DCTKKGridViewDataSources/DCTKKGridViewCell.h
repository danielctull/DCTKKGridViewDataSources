//
//  DCTKKGridViewCell.h
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTKKGridViewDataSources.h"

@protocol DCTKKGridViewCellObjectConfiguration <NSObject>
- (void)configureWithObject:(id)object;
@optional
+ (BOOL)shouldUpdateForObject:(id)object withChangedValues:(NSDictionary *)changedValues;
@end

@interface DCTKKGridViewCell : KKGridViewCell <DCTKKGridViewCellObjectConfiguration>



@end
