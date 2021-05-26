//
//  CoreDataStore.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import <Foundation/Foundation.h>

@class CSDataStack;

@interface CoreDataStore : NSObject

@property (nonnull, strong, nonatomic) CSDataStack *dataStack;

@end
