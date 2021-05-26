//
//  PixabayResponse+Extensions.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import "PixabayResponse+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface PixabayResponse (Extensions)

+ (nonnull NSString *)entityName;
- (void)copyFrom:(nonnull PixabayResponse *)object;

@end

NS_ASSUME_NONNULL_END
