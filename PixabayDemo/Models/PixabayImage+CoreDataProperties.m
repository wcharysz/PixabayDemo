//
//  PixabayImage+CoreDataProperties.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//
//

#import "PixabayImage+CoreDataProperties.h"

@implementation PixabayImage (CoreDataProperties)

+ (NSFetchRequest<PixabayImage *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"PixabayImage"];
}

@dynamic identifier;
@dynamic pageURL;
@dynamic type;
@dynamic previewURL;
@dynamic previewWidth;
@dynamic previewHeight;
@dynamic webformatURL;
@dynamic webformatWidth;
@dynamic webformatHeight;
@dynamic largeImageURL;
@dynamic fullHDURL;
@dynamic imageURL;
@dynamic imageWidth;
@dynamic imageHeight;
@dynamic imageSize;
@dynamic views;
@dynamic downloads;
@dynamic favorites;
@dynamic likes;
@dynamic comments;
@dynamic user_id;
@dynamic user;
@dynamic userImageURL;
@dynamic tags;
@dynamic response;

@end
