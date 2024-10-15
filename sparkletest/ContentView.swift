//
//  ContentView.swift
//  sparkletest
//
//  Created by Jake Wilson on 10/14/24.
//

import SwiftUI
import Sparkle

struct ContentView: View {
    var body: some View {
        VStack {
            if let version = Bundle.main.object(
                forInfoDictionaryKey: "CFBundleShortVersionString"
            ) {
                Text(
                    "\(version)"
                )
            }
        }
        .padding()
    }
}

final class CheckForUpdatesViewModel: ObservableObject {
    @Published var canCheckForUpdates = false

    init(updater: SPUUpdater) {
        updater.publisher(for: \.canCheckForUpdates)
            .assign(to: &$canCheckForUpdates)
    }
}

struct CheckForUpdatesView: View {
    @ObservedObject private var checkForUpdatesViewModel: CheckForUpdatesViewModel
    private let updater: SPUUpdater

    init(updater: SPUUpdater) {
        self.updater = updater
        self.checkForUpdatesViewModel = CheckForUpdatesViewModel(updater: updater)
    }

    var body: some View {
        Button("Check for Updates…", action: updater.checkForUpdates)
            .disabled(!checkForUpdatesViewModel.canCheckForUpdates)
    }
}

#Preview {
    ContentView()
}
