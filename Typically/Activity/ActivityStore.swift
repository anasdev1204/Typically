import Foundation
import SwiftUI

@Observable
final class ActivityStore {

    private let key = "recentActivities"

    var recents: [Activity] = []

    init() {
        load()
    }

    func add(_ activity: Activity) {

        recents.removeAll { $0.name == activity.name }

        recents.insert(activity, at: 0)

        if recents.count > 10 {
            recents = Array(recents.prefix(10))
        }

        save()
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(recents)
        else { return }

        UserDefaults.standard.set(data, forKey: key)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Activity].self, from: data)
        else { return }

        recents = decoded
    }
}
