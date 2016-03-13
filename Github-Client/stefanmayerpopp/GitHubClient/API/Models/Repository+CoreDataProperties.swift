//
//  Repository+CoreDataProperties.swift
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

extension Repository {

    @NSManaged var archive_url: String?
    @NSManaged var assignees_url: String?
    @NSManaged var blobs_url: String?
    @NSManaged var branches_url: String?
    @NSManaged var clone_url: String?
    @NSManaged var collaborators_url: String?
    @NSManaged var comments_url: String?
    @NSManaged var commits_url: String?
    @NSManaged var compare_url: String?
    @NSManaged var contents_url: String?
    @NSManaged var contributors_url: String?
    @NSManaged var created_at: NSDate?
    @NSManaged var default_branch: String?
    @NSManaged var deployments_url: String?
    @NSManaged var description_val: String?
    @NSManaged var downloads_url: String?
    @NSManaged var events_url: String?
    @NSManaged var fork: NSNumber?
    @NSManaged var forks: NSNumber?
    @NSManaged var forks_count: NSNumber?
    @NSManaged var forks_url: String?
    @NSManaged var full_name: String?
    @NSManaged var git_commits_url: String?
    @NSManaged var git_refs_url: String?
    @NSManaged var git_tags_url: String?
    @NSManaged var git_url: String?
    @NSManaged var has_downloads: NSNumber?
    @NSManaged var has_issues: NSNumber?
    @NSManaged var has_pages: NSNumber?
    @NSManaged var has_wiki: NSNumber?
    @NSManaged var homepage: String?
    @NSManaged var hooks_url: String?
    @NSManaged var html_url: String?
    @NSManaged var id: NSNumber?
    @NSManaged var issue_comment_url: String?
    @NSManaged var issue_events_url: String?
    @NSManaged var issues_url: String?
    @NSManaged var keys_url: String?
    @NSManaged var labels_url: String?
    @NSManaged var language: String?
    @NSManaged var languages_url: String?
    @NSManaged var merges_url: String?
    @NSManaged var milestones_url: String?
    @NSManaged var mirror_url: String?
    @NSManaged var name: String?
    @NSManaged var notifications_url: String?
    @NSManaged var open_issues: NSNumber?
    @NSManaged var open_issues_count: NSNumber?
    @NSManaged var private_val: NSNumber?
    @NSManaged var pulls_url: String?
    @NSManaged var pushed_at: NSDate?
    @NSManaged var releases_url: String?
    @NSManaged var size: NSNumber?
    @NSManaged var ssh_url: String?
    @NSManaged var stargazers_count: NSNumber?
    @NSManaged var stargazers_url: String?
    @NSManaged var statuses_url: String?
    @NSManaged var subscribers_url: String?
    @NSManaged var subscription_url: String?
    @NSManaged var svn_url: String?
    @NSManaged var tags_url: String?
    @NSManaged var teams_url: String?
    @NSManaged var trees_url: String?
    @NSManaged var updated_at: NSDate?
    @NSManaged var url: String?
    @NSManaged var watchers: NSNumber?
    @NSManaged var watchers_count: NSNumber?
    @NSManaged var user: User?

}
