//
//  ViewModel.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import <Foundation/Foundation.h>
#import "PixabayImage+CoreDataClass.h"

@class ViewController;
@class CoreDataStore;

@interface ViewModel : NSObject

@property (nonnull, strong, nonatomic) NSFetchedResultsController<PixabayImage *> *resultController;

-(nullable instancetype)initWith:(nullable ViewController *)controller;

-(void)downloadPhotos:(nonnull NSString *)searchedTerm;
- (void)clearCache;

@end
