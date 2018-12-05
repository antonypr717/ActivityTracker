//
//  AddActivitiesInteractor.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 04/12/18.
//  Copyright (c) 2018 Antony Raphel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddActivitiesBusinessLogic {
    func doAdd(request: AddActivities.Add.Request)
    func addMember(request: AddActivities.Member.Request)
}

protocol AddActivitiesDataStore {
    var member: AddActivities.Member.Response.MemberResponse? { get set }
    var members: [AddActivities.Member.Response.MemberResponse] { get set }
}

class AddActivitiesInteractor: AddActivitiesBusinessLogic, AddActivitiesDataStore {
    var presenter: AddActivitiesPresentationLogic?
    var worker: AddActivitiesWorker?
    var member: AddActivities.Member.Response.MemberResponse?
    var members: [AddActivities.Member.Response.MemberResponse] = []
    
    // MARK: Do Add
    
    func doAdd(request: AddActivities.Add.Request) {
        let validation = validateForm(request: request)
        if validation.isValid {
            worker = AddActivitiesWorker()
            worker?.saveActivity(request: request, members: members, handler: { [weak self] in
                guard let strongSelf = self else { return }
                let response = AddActivities.Add.Response(success: true,
                                                          message: "Activity added successfully!")
                strongSelf.presenter?.presentAlert(response: response)
            })
        } else {
            let response = AddActivities.Add.Response(success: validation.isValid,
                                                      message: validation.message)
            presenter?.presentAlert(response: response)
        }
    }
    
    func addMember(request: AddActivities.Member.Request) {
        let list = getMembers()
        let response = AddActivities.Member.Response(members: list)
        presenter?.presentMembers(response: response)
    }
    
    private func validateForm(request: AddActivities.Add.Request) -> (isValid: Bool, message: String) {
        var isValid = false
        var msg = ""
        if request.title == "" {
            msg = "Please enter title"
        } else if request.description == "" {
            msg = "Please enter description"
        } else if request.dueDate == nil {
            msg = "Please select due date for the activity"
        } else if request.image == nil || request.image == UIImage(named: "Placeholder-image") {
            msg = "Please choose an image for the activity"
        } else if members.count == 0 {
            msg = "Please add a member for the activity"
        } else {
            isValid = true
        }
        return (isValid, msg)
    }
    
    private func getMembers() -> [AddActivities.Member.Response.MemberResponse] {
        guard let aMember = member else {
            return []
        }
        members += [AddActivities.Member.Response.MemberResponse(title: aMember.title,
                                                                 photo: aMember.photo)]
        return members
    }
}