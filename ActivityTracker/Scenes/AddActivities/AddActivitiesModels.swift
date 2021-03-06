//
//  AddActivitiesModels.swift
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

enum AddActivities {
    // MARK: Use cases
    
    enum Add {
        struct Request {
            var title: String
            var description: String
            var dueDate: Date?
            var image: UIImage?
        }
        struct Response {
            var success: Bool
            var message: String
        }
        struct ViewModel {
            var success: Bool
            var message: String
        }
    }
    
    enum Member {
        struct Request {
        }
        struct Response {
            struct MemberResponse {
                var title: String
                var photo: UIImage
            }
            var members: [MemberResponse]
        }
        struct ViewModel {
            struct MemberViewModel {
                var title: String
                var photo: UIImage
                var isLast: Bool
            }
            var members: [MemberViewModel]
        }
    }
}
