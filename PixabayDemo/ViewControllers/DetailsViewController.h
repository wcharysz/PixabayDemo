//
//  DetailsViewController.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 25.04.21.
//

#import <UIKit/UIKit.h>
@class PixabayImage;

@interface DetailsViewController : UIViewController

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder andModel:(nonnull PixabayImage *)model;
+ (nonnull NSString *)identifier;

@end
