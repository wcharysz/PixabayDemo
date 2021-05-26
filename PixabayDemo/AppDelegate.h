//
//  AppDelegate.h
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

