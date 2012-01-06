//
//  DCTKKGridViewCell.m
//  Convene
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "DCTKKGridViewCell.h"


@implementation DCTKKGridViewCell

- (void)configureWithObject:(id)object {}

- (NSString *)reuseIdentifier {
	return NSStringFromClass([self class]);
}

+ (id)cellForGridView:(KKGridView *)gridView {
	
	KKGridViewCell *cell = (KKGridViewCell *)[gridView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
	
	if (cell) return cell;
	
	NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(self) ofType:@"nib"];
	
	if (path != nil) {
		
		NSArray *items = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
		
		for (id object in items)
			if ([object isKindOfClass:self])
				return object;
	}
	
	return [super cellForGridView:gridView];
}

@end
