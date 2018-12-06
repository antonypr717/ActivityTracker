//
//  ActivitiesModels.swift
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

enum Activities {
    // MARK: Use cases
    
    enum Fetch {
        struct Request {
        }
        struct Response {
            var index: Int?
            var seconds: Int?
            var activity: [ActivityEntity]
        }
        struct ViewModel {
            struct ActivityViewModel {
                struct MembersViewModel {
                    var photo: UIImage
                    var name: String
                }
                var logo: UIImage
                var membersCount: String
                var dueDate: String
                var title: String
                var desc: String
                var checkList: String
                var isStarted: Bool
                var shouldStart: Bool
                var time: String
                var members: [MembersViewModel]
            }
            var items: [ActivityViewModel]
        }
    }
    
    enum Time {
        struct Request {
            var index: Int
        }
        struct Response {
            var index: Int
            var seconds: Int
        }
        struct ViewModel {
        }
    }
}
