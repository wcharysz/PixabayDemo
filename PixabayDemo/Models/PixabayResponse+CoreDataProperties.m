//
//  PixabayResponse+CoreDataProperties.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//
//

#import "PixabayResponse+CoreDataProperties.h"

@implementation PixabayResponse (CoreDataProperties)

+ (NSFetchRequest<PixabayResponse *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PixabayResponse"];
}

@dynamic total;
@dynamic totalHits;
@dynamic searchedTerm;
@dynamic hits;

@end
