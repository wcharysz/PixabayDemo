//
//  ViewModelExtension.swift
//  PixabayDemo
//
//  Created by Wojciech Charysz on 24.04.21.
//

import Foundation
import CoreStore

@objc extension ViewModel {
    
    @objc static func createFetchResultController(_ coreData: CSDataStack) -> NSFetchedResultsController<PixabayImage> {
        coreData.bridgeToSwift.createFetchedResultsController(From<PixabayImage>(), OrderBy<PixabayImage>(.ascending(\.identifier)))
    }
 
}

