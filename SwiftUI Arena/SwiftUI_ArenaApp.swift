//
//  SwiftUI_ArenaApp.swift
//  SwiftUI Arena
//
//  Created by Bishoy Badea [Pharma] on 27/09/2022.
//

import SwiftUI

@main
struct SwiftUI_ArenaApp: App {
    var body: some Scene {
        WindowGroup {
            RegisterView(viewModel: .init())
        }
    }
}
