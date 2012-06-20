//
//  DCTKKGridViewDataSource.h
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridView.h>

@class DCTParentKKGridViewDataSource;

@interface DCTKKGridViewDataSource : NSObject <KKGridViewDataSource>

@property (nonatomic, assign) Class cellClass;
@property (nonatomic, strong) IBOutlet KKGridView *gridView;
@property (nonatomic, assign) DCTParentKKGridViewDataSource *parent;

/** A convinient way to repload the cells of the data source, this 
 should be overridden by subclasses to provide desired results.
 */
- (void)reloadData;

/** To get the associated object from the data source for the given 
 index path. By default this returns the index path, but subclasses
 should return the correct object to use.
 
 If the cellClass conforms to FRCTableViewCellObjectConfiguration,
 it is this object that will be given to the cell when
 configureWithObject: is called.
 
 @param indexPath The index path in the co-ordinate space of the data source.
 
 @return The representing object.
 */
- (id)objectAtIndexPath:(KKIndexPath *)indexPath;

/** To enable a data source to have different cell classes for different
 index paths.
 
 This method returns the class in the property cellClass. Subclasses
 should override for different results.
 
 @param indexPath The index path in the co-ordinate space of the data source.
 
 @return The class of the cell to use.
 */
- (Class)cellClassAtIndexPath:(KKIndexPath *)indexPath;

/** This allows subclasses to simply configure the cell without needing
 to implement the standard tableView:cellForRowAtIndexPath: method.
 
 @param cell The cell to be configured.
 @param indexPath The index path in the co-ordinate space of the data source.
 @param object The represented object at the indexPath.
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(KKIndexPath *)indexPath withObject:(id)object;

@end
