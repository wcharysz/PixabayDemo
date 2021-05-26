//
//  DetailsViewController.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 25.04.21.
//

#import "DetailsViewController.h"
#import "PixabayImage+CoreDataClass.h"
#import "PixabayImage+CoreDataProperties.h"
#import "TextTableViewCell.h"
#import "ImageTableViewCell.h"

@import AFNetworking;

@interface DetailsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nullable, weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonnull, strong, nonatomic) PixabayImage *model;


@end

@implementation DetailsViewController

+ (nonnull NSString *)identifier {
    return NSStringFromClass([self class]);
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder andModel:(nonnull PixabayImage *)model {
    self = [super initWithCoder:coder];
    
    if (self) {
        _model = model;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Get rid off empty cells
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ImageTableViewCell identifier] forIndexPath:indexPath];
            
            if (self.model.largeImageURL) {
                NSURL *url = [NSURL URLWithString:self.model.largeImageURL];
                NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
                NSData *data = [[AFImageDownloader defaultURLCache] cachedResponseForRequest:request].data;
                
                if (data) {
                    cell.bigImage.image = [UIImage imageWithData:data];
                } else {
                    [cell.bigImage setImageWithURL:url];
                }
            }
            
            return cell;
        }
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        {
            TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TextTableViewCell identifier] forIndexPath:indexPath];
            NSString *text = @"";
            NSString *unknown = @"Unknown";
            
            switch (indexPath.row) {
                case 1:
                    text = [NSString stringWithFormat:@"User Name: %@", self.model.user ?: unknown];
                    break;
                case 2:
                    text = [NSString stringWithFormat:@"Tags: %@", [self.model.tags componentsJoinedByString:@"; "] ?: unknown];
                    break;
                case 3:
                    text = [NSString stringWithFormat:@"Likes Count: %@", [NSNumberFormatter localizedStringFromNumber:@(self.model.likes) numberStyle:NSNumberFormatterDecimalStyle]];
                    break;
                case 4:
                    text = [NSString stringWithFormat:@"Favourites Count: %@", [NSNumberFormatter localizedStringFromNumber:@(self.model.favorites) numberStyle:NSNumberFormatterDecimalStyle]];
                    break;
                case 5:
                    text = [NSString stringWithFormat:@"Comments Count: %@", [NSNumberFormatter localizedStringFromNumber:@(self.model.comments) numberStyle:NSNumberFormatterDecimalStyle]];
                    break;
                default:
                    break;
            }
            
            cell.detailsLabel.text = text;
            [cell.detailsLabel sizeToFit];
            
            return cell;
        }
        default:
            return  [UITableViewCell new];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  6;
}

@end



