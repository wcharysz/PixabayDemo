//
//  ViewController.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "TableViewCell.h"
#import "DetailsViewController.h"

@import AFNetworking;

@interface ViewController()

@property (nullable, weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonnull, strong, nonatomic) ViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[ViewModel alloc] initWith:self];
    [self.viewModel clearCache];
    [self.viewModel downloadPhotos:@"apples"];
}

- (void)showError:(nullable NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription ?: @"Unknown error" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.resultController.sections.count ?: 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.resultController.sections[section].numberOfObjects ?: 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TableViewCell identifier] forIndexPath:indexPath];
    PixabayImage *model = [self.viewModel.resultController objectAtIndexPath:indexPath];
    cell.userName.text = model.user;
    NSString *tags = [model.tags componentsJoinedByString:@", "];
    cell.tags.text = tags;
    
    if (model.previewURL) {
        NSURL *url = [NSURL URLWithString:model.previewURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
        NSData *data = [[AFImageDownloader defaultURLCache] cachedResponseForRequest:request].data;
        
        if (data) {
            cell.thumbnailView.image = [UIImage imageWithData:data];
        } else {
            [cell.thumbnailView setImageWithURL:url];
        }
    }
    
    return cell ?: [UITableViewCell new];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.viewModel.resultController.sections[section].name;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PixabayImage *model = [self.viewModel.resultController objectAtIndexPath:indexPath];
    DetailsViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:[DetailsViewController identifier] creator:^__kindof UIViewController * _Nullable(NSCoder * _Nonnull coder) {
        return [[DetailsViewController alloc] initWithCoder:coder andModel:model];
    }];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
    
    if (searchBar.text && searchBar.text > 0) {
        searchBar.text = nil;
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    
    if (!searchBar.text || [searchBar.text isEqualToString:@""] || searchBar.text.length == 0) {
        [searchBar resignFirstResponder];
        return;
    }
    
    [self.viewModel clearCache];
    [self.viewModel downloadPhotos:searchBar.text];
    [searchBar resignFirstResponder];
}

@end
