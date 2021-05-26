//
//  PixabayImage+CoreDataProperties.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//
//

#import "PixabayImage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PixabayImage (CoreDataProperties)

+ (NSFetchRequest<PixabayImage *> *)fetchRequest;

@property (nonatomic) int64_t identifier;
@property (nullable, nonatomic, copy) NSString *pageURL;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *previewURL;
@property (nonatomic) float previewWidth;
@property (nonatomic) float previewHeight;
@property (nullable, nonatomic, copy) NSString *webformatURL;
@property (nonatomic) float webformatWidth;
@property (nonatomic) float webformatHeight;
@property (nullable, nonatomic, copy) NSString *largeImageURL;
@property (nullable, nonatomic, copy) NSString *fullHDURL;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nonatomic) float imageWidth;
@property (nonatomic) float imageHeight;
@property (nonatomic) int64_t imageSize;
@property (nonatomic) int64_t views;
@property (nonatomic) int64_t downloads;
@property (nonatomic) int32_t favorites;
@property (nonatomic) int32_t likes;
@property (nonatomic) int32_t comments;
@property (nonatomic) int64_t user_id;
@property (nullable, nonatomic, copy) NSString *user;
@property (nullable, nonatomic, copy) NSString *userImageURL;
@property (nullable, nonatomic, retain) NSArray<NSString *> *tags;
@property (nullable, nonatomic, retain) PixabayResponse *response;

@end

NS_ASSUME_NONNULL_END
