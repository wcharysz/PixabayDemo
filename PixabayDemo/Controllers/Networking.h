//
//  Networking.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Networking : NSObject

- (void)downloadPhotos:(nonnull NSString*)searchedTerm withCompletion:(nullable void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
