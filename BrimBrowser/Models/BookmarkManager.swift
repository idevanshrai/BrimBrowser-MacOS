//
//  BookmarkManager.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 17/9/25.
//
import Foundation

struct Bookmark: Identifiable, Codable {
    let id: UUID
    let title: String
    let url: String

    init(id: UUID = UUID(), title: String, url: String) {
        self.id = id
        self.title = title
        self.url = url
    }
}

final class BookmarkManager: ObservableObject {
    @Published var bookmarks: [Bookmark] = []

    private let key = "Bookmarks"

    init() {
        load()
    }

    func addBookmark(title: String, url: String) {
        let bookmark = Bookmark(title: title, url: url)
        bookmarks.append(bookmark)
        save()
    }

    func removeBookmark(_ bookmark: Bookmark) {
        bookmarks.removeAll { $0.id == bookmark.id }
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(bookmarks) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let saved = try? JSONDecoder().decode([Bookmark].self, from: data) {
            bookmarks = saved
        }
    }
}

