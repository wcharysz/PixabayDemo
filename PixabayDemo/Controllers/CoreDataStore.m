//
//  CoreDataStore.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import "CoreDataStore.h"

@import CoreStore;

static NSString *storeModelName = @"PixabayDemo";

@implementation CoreDataStore

- (nonnull instancetype)init {
    self = [super init];
    
    if (self) {
        _dataStack = [[CSDataStack alloc] initWithXcodeModelName:storeModelName bundle:[NSBundle mainBundle] versionChain:nil];
        NSError *error;
        [_dataStack addSQLiteStorageAndWaitAndReturnError:&error];
    }
    
    return self;
}


@end
