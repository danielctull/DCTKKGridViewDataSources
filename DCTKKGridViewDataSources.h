//
//  DCTKKGridViewDataSources.h
//  DCTKKGridViewDataSources
//
//  Created by Daniel Tull on 06.01.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Availability.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_4_3
#warning "This library uses ARC which is only available in iOS SDK 4.3 and later."
#endif

#if !defined dct_weak && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0

#define dct_weak weak
#define __dct_weak __weak
#define dct_nil(x)

#elif !defined dct_weak && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0

#define dct_weak unsafe_unretained
#define __dct_weak __unsafe_unretained
#define dct_nil(x) x = nil

#endif


#ifndef dctkkgridviewdatasources
#define dctkkgridviewdatasources_1_0     10000
#define dctkkgridviewdatasources         dctkkgridviewdatasources_1_0
#endif
