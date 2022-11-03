//
//  iOS_RESTful_ApiApp.swift
//  iOS RESTful Api
//
//  Created by Sefa DİNÇER on 2.11.2022.
//

import SwiftUI

@main
struct iOS_RESTful_ApiApp: App {
    var body: some Scene {
        WindowGroup {
            UsersListView().onAppear {
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
        }
    }
}
