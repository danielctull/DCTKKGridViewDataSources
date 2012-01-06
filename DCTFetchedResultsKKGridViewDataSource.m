//
//  KKGridViewDataSource.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTFetchedResultsKKGridViewDataSource.h"

@interface DCTFetchedResultsKKGridViewDataSource () <NSFetchedResultsControllerDelegate>
@end

@implementation DCTFetchedResultsKKGridViewDataSource

@synthesize fetchedResultsController;

- (id)objectAtIndexPath:(KKIndexPath *)indexPath {
	return [self.fetchedResultsController objectAtIndexPath:indexPath.NSIndexPath];
}

#pragma mark - FRCFetchedResultsTableViewDataSource

- (void)setFetchedResultsController:(NSFetchedResultsController *)frc {
	
	if ([fetchedResultsController isEqual:frc]) return;
	
	fetchedResultsController.delegate = nil;
	fetchedResultsController = frc;
	
	fetchedResultsController.delegate = self;
	[fetchedResultsController performFetch:nil];
	
	[self.gridView reloadData];
}

#pragma mark - KKGridViewDataSource

- (NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView {
	return [[self.fetchedResultsController sections] count];
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	return [sectionInfo numberOfObjects];
}

- (KKGridViewCell *)gridView:(KKGridView *)gv cellForItemAtIndexPath:(KKIndexPath *)indexPath {
	
	NSInteger amount = [self gridView:gv numberOfItemsInSection:indexPath.section];
    if (indexPath.index >= amount) {
        NSLog(@"%@:%@ RELOADING GRID VIEW NAH NAH NAH", self, NSStringFromSelector(_cmd));
        [self.gridView reloadData];
        return [self.cellClass	cellForGridView:gv];
    }
	
	return [super gridView:gv cellForItemAtIndexPath:indexPath];
}

- (NSString *)gridView:(KKGridView *)gridView titleForHeaderInSection:(NSUInteger)section { 
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForGridView:(KKGridView *)gridView {
	return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)gridView:(KKGridView *)gridView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
	return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {}

- (void)controller:(NSFetchedResultsController *)controller 
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath {
	
    KKGridView *gv = self.gridView;
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [gv insertItemsAtIndexPaths:[NSArray arrayWithObject:[KKIndexPath indexPathWithNSIndexPath:indexPath]]
						  withAnimation:KKGridViewAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
			[gv deleteItemsAtIndexPaths:[NSArray arrayWithObject:[KKIndexPath indexPathWithNSIndexPath:indexPath]]
						  withAnimation:KKGridViewAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
			[gv reloadItemsAtIndexPaths:[NSArray arrayWithObject:[KKIndexPath indexPathWithNSIndexPath:indexPath]]];
            break;
			
        case NSFetchedResultsChangeMove:
			[gv moveItemAtIndexPath:[KKIndexPath indexPathWithNSIndexPath:indexPath]
						toIndexPath:[KKIndexPath indexPathWithNSIndexPath:newIndexPath]];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {}

@end
