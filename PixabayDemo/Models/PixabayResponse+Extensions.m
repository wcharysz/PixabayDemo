//
//  PixabayResponse+Extensions.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import "PixabayResponse+Extensions.h"
#import "PixabayResponse+CoreDataProperties.h"

@implementation PixabayResponse (Extensions)

+ (nonnull NSString *)entityName {
    return NSStringFromClass([self class]);
}

- (void)copyFrom:(nonnull PixabayResponse *)object {
    self.total = object.total;
    self.totalHits = object.totalHits;
    self.hits = object.hits;
}

@end
