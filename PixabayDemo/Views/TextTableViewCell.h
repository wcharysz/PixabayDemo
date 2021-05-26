//
//  TextTableViewCell.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 25.04.21.
//

#import <UIKit/UIKit.h>


@interface TextTableViewCell : UITableViewCell

@property (nullable, weak, nonatomic) IBOutlet UILabel *detailsLabel;

+ (nonnull NSString *)identifier;

@end

