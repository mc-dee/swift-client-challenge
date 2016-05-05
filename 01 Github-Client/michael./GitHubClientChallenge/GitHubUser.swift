// ---------------------------------------------------
//  GitHubUser.swift
//  GitHubClientChallenge
//
//  Created by Michael on 13.03.2016.
//  Copyright © 2016 Michael Fenske. See LICENSE.txt.
// ---------------------------------------------------


import Foundation


struct GitHubUser {

    let login: String
    let name: String
    var repos: [GitHubRepository]
}
