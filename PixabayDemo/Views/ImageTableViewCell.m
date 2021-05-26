//
//  ImageTableViewCell.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 25.04.21.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (nonnull NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
