//
//  User+CoreDataProperties.swift
//  GitHubClient
//
//  Created by Stefan Popp on 13.03.16.
//  Copyright © 2016 Stefan Mayer-Popp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var avatar_url: String?
    @NSManaged var events_url: String?
    @NSManaged var followers_url: String?
    @NSManaged var following_url: String?
    @NSManaged var gists_url: String?
    @NSManaged var gravatar_id: String?
    @NSManaged var html_url: String?
    @NSManaged var id: NSNumber?
    @NSManaged var login: String?
    @NSManaged var organizations_url: String?
    @NSManaged var received_events_url: String?
    @NSManaged var repos_url: String?
    @NSManaged var site_admin: String?
    @NSManaged var starred_url: String?
    @NSManaged var subscriptions_url: String?
    @NSManaged var type: String?
    @NSManaged var url: String?
    @NSManaged var repositories: Repository?

}
