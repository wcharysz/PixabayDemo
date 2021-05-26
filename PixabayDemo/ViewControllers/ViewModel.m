//
//  ViewModel.m
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import "ViewModel.h"
#import "ViewController.h"
#import "Networking.h"
#import "CoreDataStore.h"
#import "PixabayImage+CoreDataClass.h"
#import "PixabayImage+CoreDataProperties.h"
#import "PixabayResponse+CoreDataClass.h"
#import "PixabayResponse+CoreDataProperties.h"
#import "PixabayResponse+Extensions.h"
#import "PixabayDemo-Swift.h"

@import CoreStore;


@interface ViewModel() <NSFetchedResultsControllerDelegate>

@property (nullable, weak, nonatomic) ViewController *controller;
@property (nonnull, strong, nonatomic) Networking *api;
@property (nonnull, strong, nonatomic) CoreDataStore *coreData;

@end

@implementation ViewModel

-(nullable instancetype)initWith:(nullable ViewController *)controller {
    self = [super init];
    
    if (self) {
        _controller = controller;
        _api = [Networking new];
        _coreData = [CoreDataStore new];
        _resultController = [ViewModel createFetchResultController:_coreData.dataStack];
        _resultController.delegate = self;

        NSError *error;
        [_resultController performFetch:&error];
    }
    
    return self;
}

- (void)clearCache {
    typeof(self) __weak weakSelf = self;

    NSError *error;
    BOOL result = [self.coreData.dataStack beginSynchronous:^(CSSynchronousDataTransaction * _Nonnull transaction) {
        NSArray<PixabayResponse *> *responses = [transaction fetchAllFrom:CSFromClass([PixabayResponse class]) fetchClauses:@[]];
        NSArray<PixabayImage *> *hits = [transaction fetchAllFrom:CSFromClass([PixabayImage class]) fetchClauses:@[]];
        [transaction deleteObjects:responses];
        [transaction deleteObjects:hits];
        NSError *commitError;
        BOOL commitResult = [transaction commitAndWaitWithError:&commitError];
        
        if (!commitResult && commitError) {
            [weakSelf.controller showError:error];
        }
        
    } error:&error];
    
    if (!result && error != nil) {
        [self.controller showError:error];
    }
}

-(void)downloadPhotos:(nonnull NSString *)searchedTerm {
    typeof(self) __weak weakSelf = self;
    [self.api downloadPhotos:searchedTerm withCompletion:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error && !responseObject) {
            [weakSelf.controller showError:error];
            return;
        }
        
        NSDictionary *json = responseObject;
        
        [weakSelf.coreData.dataStack beginAsynchronous:^(CSAsynchronousDataTransaction * _Nonnull transaction) {            
            PixabayResponse *responseToSave = [transaction createInto:CSIntoClass([PixabayResponse class])];
            responseToSave.searchedTerm = searchedTerm;
            
            NSString *jsonKey = @"JSONKeyPath";
            
            for (NSPropertyDescription *propertyDescription in PixabayResponse.entity.properties) {
                
                NSString *key = propertyDescription.userInfo[jsonKey];
                
                if (!key) {
                    continue;
                }
                
                id<NSObject> value = json[key];
                
                if ([key isEqualToString:@"hits"] && [value isKindOfClass:[NSArray class]]) {
                    //hits
                    NSArray<NSDictionary *> *hits = (NSArray *)value;
                    for (NSDictionary *hit in hits) {
                        PixabayImage *imageModel = [transaction createInto:CSIntoClass([PixabayImage class])];
                        
                        for (NSPropertyDescription *imageProperty in PixabayImage.entity.properties) {
                            key = imageProperty.userInfo[jsonKey];
                            
                            if (!key) {
                                continue;
                            }
                            
                            id<NSObject> modelValue = hit[key];
                            
                            if ([key isEqualToString:@"id"]) {
                                key = @"identifier";
                            }
                            
                            //parse tags
                            if ([key isEqualToString:@"tags"]) {
                                NSString *container = (NSString *)modelValue;
                                NSArray<NSString *> *strings = [container componentsSeparatedByString:@", "];
                                modelValue = strings;
                            }
                            
                            [imageModel setValue:modelValue forKey:key];
                        }
                        
                        [responseToSave addHitsObject:imageModel];
                        imageModel.response = responseToSave;
                    }
                } else {
                    [responseToSave setValue:value forKey:key];
                }
            }
            
            [transaction commitWithSuccess:^{

            } failure:^(CSError * _Nonnull error) {
                [weakSelf.controller showError:error];
            }];
        }];
    }];
}

#pragma mark NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.controller.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.controller.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.controller.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            if (newIndexPath) {
                [self.controller.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
        case NSFetchedResultsChangeDelete:
            if (indexPath) {
                [self.controller.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
        case NSFetchedResultsChangeUpdate:
            if (indexPath) {
                [self.controller.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
        case NSFetchedResultsChangeMove:
            if (indexPath && newIndexPath) {
                [self.controller.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            }
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.controller.tableView endUpdates];
}

@end
