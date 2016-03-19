// -------------------------------------------------------
//  GitHubUser.swift
//  GitHubClientChallenge
//
//  Created by Michael on 13.03.2016.
//  Copyright © 2016 Michael Fenske. All rights reserved.
// -------------------------------------------------------


import Foundation


struct GitHubUser {

    let login: String
    let name: String
    var repos: [GitHubRepository]
}
