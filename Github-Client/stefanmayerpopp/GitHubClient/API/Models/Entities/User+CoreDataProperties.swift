//
//  User+CoreDataProperties.swift
//  GitHubClient
//
//  Created by Stefan Popp on 13.03.16.
//
//  This file is part of GitHubCLient.
//
//  GitHubCLient is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  GitHubCLient is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with GitHubCLient.  If not, see <http://www.gnu.org/licenses/>.
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
