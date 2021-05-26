//
//  ImageTableViewCell.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 25.04.21.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell

@property (nullable, weak, nonatomic) IBOutlet UIImageView *bigImage;

+ (nonnull NSString *)identifier;


@end

