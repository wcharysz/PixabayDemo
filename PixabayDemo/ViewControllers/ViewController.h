//
//  ViewController.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nullable, weak, nonatomic) IBOutlet UITableView *tableView;

- (void)showError:(nullable NSError *)error;

@end

