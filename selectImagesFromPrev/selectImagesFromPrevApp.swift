//
//  selectImagesFromPrevApp.swift
//  selectImagesFromPrev
//
//  Created by Marcello Fiore on 05/04/24.
//

import SwiftUI

@main
struct selectImagesFromPrevApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(images: [UIImage(named: "mockImage")!])
        }
    }
}
