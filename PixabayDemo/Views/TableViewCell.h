//
//  TableViewCell.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nullable, weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (nullable, weak, nonatomic) IBOutlet UILabel *userName;
@property (nullable, weak, nonatomic) IBOutlet UITextView *tags;

+ (nonnull NSString *)identifier;

@end
