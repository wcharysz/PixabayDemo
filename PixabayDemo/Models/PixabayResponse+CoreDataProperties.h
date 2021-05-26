//
//  PixabayResponse+CoreDataProperties.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//
//

#import "PixabayResponse+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PixabayResponse (CoreDataProperties)

+ (NSFetchRequest<PixabayResponse *> *)fetchRequest;

@property (nonatomic) int32_t total;
@property (nonatomic) int16_t totalHits;
@property (nullable, nonatomic, copy) NSString *searchedTerm;
@property (nullable, nonatomic, retain) NSSet<PixabayImage *> *hits;

@end

@interface PixabayResponse (CoreDataGeneratedAccessors)

- (void)addHitsObject:(PixabayImage *)value;
- (void)removeHitsObject:(PixabayImage *)value;
- (void)addHits:(NSSet<PixabayImage *> *)values;
- (void)removeHits:(NSSet<PixabayImage *> *)values;

@end

NS_ASSUME_NONNULL_END
