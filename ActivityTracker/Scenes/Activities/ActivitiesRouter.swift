//
//  ActivitiesRouter.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 03/12/18.
//  Copyright (c) 2018 Antony Raphel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ActivitiesRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ActivitiesDataPassing {
    var dataStore: ActivitiesDataStore? { get }
}

class ActivitiesRouter: NSObject, ActivitiesRoutingLogic, ActivitiesDataPassing {
    weak var viewController: ActivitiesViewController?
    var dataStore: ActivitiesDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: ActivitiesViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ActivitiesDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
