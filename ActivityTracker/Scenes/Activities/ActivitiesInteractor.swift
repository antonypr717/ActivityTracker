//
//  ActivitiesInteractor.swift
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

protocol ActivitiesBusinessLogic {
    func doSomething(request: Activities.Something.Request)
}

protocol ActivitiesDataStore {
    //var name: String { get set }
}

class ActivitiesInteractor: ActivitiesBusinessLogic, ActivitiesDataStore {
    var presenter: ActivitiesPresentationLogic?
    var worker: ActivitiesWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Activities.Something.Request) {
        worker = ActivitiesWorker()
        worker?.doSomeWork()
        
        let response = Activities.Something.Response()
        presenter?.presentSomething(response: response)
    }
}