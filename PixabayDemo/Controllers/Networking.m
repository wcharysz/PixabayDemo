//
//  Networking.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import "Networking.h"
@import AFNetworking;

static NSString *photoSearchURL = @"https://pixabay.com/api/";
static NSString *apiKey = @"21312551-65787bbfe2af66054f3a8e9e7";

@implementation Networking

- (void)downloadPhotos:(nonnull NSString*)searchedTerm withCompletion:(nullable void (^)(NSURLResponse * _Nonnull response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableString *stringURL = [photoSearchURL stringByAppendingFormat:@"?key=%@",apiKey].mutableCopy;
    [stringURL appendFormat:@"&q=%@",[searchedTerm stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [stringURL appendString:@"&image_type=photo"];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (completionHandler) {
            completionHandler(response, responseObject, error);
        }
    }];
    
    [task resume];
}

@end
