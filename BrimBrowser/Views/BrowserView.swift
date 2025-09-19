//
//  BrowserView.swift
//  BrimBrowser
//
//  Created by Devansh Rai on 17/9/25.
//
import SwiftUI

struct BrowserView: View {
    @StateObject var tabManager = TabManager()
    @StateObject var bookmarkManager = BookmarkManager()
    @State private var hoveredTab: UUID?

    var body: some View {
        VStack(spacing: 0) {
            topBar
            if let currentTab = tabManager.currentTab, currentTab.url.isEmpty {
                HomePage(onSearch: { query in
                    tabManager.addressBarText = query
                    tabManager.loadCurrent()
                }, bookmarks: bookmarkManager.bookmarks)
            } else {
                contentArea
            }
            tabBar
        }
        .background(.ultraThinMaterial) // frosted Safari look
    }

    // MARK: - Top Bar
    private var topBar: some View {
        HStack(spacing: 8) {
            Button(action: { tabManager.currentTab?.webView.goBack() }) {
                Image(systemName: "chevron.left")
            }.buttonStyle(.borderless)

            Button(action: { tabManager.currentTab?.webView.goForward() }) {
                Image(systemName: "chevron.right")
            }.buttonStyle(.borderless)

            Button(action: { tabManager.currentTab?.webView.reload() }) {
                Image(systemName: "arrow.clockwise")
            }.buttonStyle(.borderless)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)

                TextField("Search or enter website",
                          text: $tabManager.addressBarText,
                          onCommit: { tabManager.loadCurrent() })
                    .textFieldStyle(.plain)
                    .disableAutocorrection(true)
            }
            .padding(6)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .shadow(radius: 1)

            Button(action: { tabManager.addTab() }) {
                Image(systemName: "plus")
            }.buttonStyle(.borderless)

            Menu {
                ForEach(bookmarkManager.bookmarks) { bm in
                    Button(bm.title) {
                        tabManager.addressBarText = bm.url
                        tabManager.loadCurrent()
                    }
                }
            } label: {
                Image(systemName: "bookmark")
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .background(.thinMaterial)
    }

    // MARK: - Content Area
    private var contentArea: some View {
        Group {
            if let currentTab = tabManager.currentTab {
                WebViewContainer(webView: currentTab.webView.webView)
                    .edgesIgnoringSafeArea(.bottom)
            } else {
                Text("No Tab Open")
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
    }

    // MARK: - Tab Bar
    private var tabBar: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tabManager.tabs) { tab in
                        tabButton(tab)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
        }
        .background(.ultraThinMaterial)
    }

    // MARK: - Tab Button
    private func tabButton(_ tab: BrowserTab) -> some View {
        HStack(spacing: 4) {
            Text(tab.title)
                .lineLimit(1)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    tabManager.currentTab?.id == tab.id
                    ? AnyShapeStyle(.ultraThinMaterial)
                    : AnyShapeStyle(Color.clear)
                )
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation {
                        tabManager.switchToTab(tab)
                    }
                }

            Button(action: { withAnimation { tabManager.closeTab(tab) } }) {
                Image(systemName: "xmark.circle.fill")
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 2)
        .background(tabHighlight(tab))
        .cornerRadius(8)
        .onHover { hovering in
            if hovering && tabManager.currentTab?.id != tab.id {
                withAnimation { hoveredTab = tab.id }
            } else {
                withAnimation { hoveredTab = nil }
            }
        }
    }

    // Hover/Active Tab Background
    private func tabHighlight(_ tab: BrowserTab) -> Color {
        if tabManager.currentTab?.id == tab.id {
            return Color.accentColor.opacity(0.15)
        } else if hoveredTab == tab.id {
            return Color.gray.opacity(0.1)
        } else {
            return Color.clear
        }
    }
}

// MARK: - Home Page
struct HomePage: View {
    var onSearch: (String) -> Void
    var bookmarks: [Bookmark]

    @State private var searchText: String = ""

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Text("Brim Browser")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search or enter website", text: $searchText, onCommit: {
                    onSearch(searchText)
                })
                .textFieldStyle(.plain)
                .disableAutocorrection(true)
            }
            .padding(12)
            .frame(maxWidth: 500)
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .shadow(radius: 2)

            if !bookmarks.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Favorites")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 20) {
                        ForEach(bookmarks.prefix(6)) { bm in
                            VStack {
                                Circle()
                                    .fill(Color.accentColor.opacity(0.2))
                                    .frame(width: 50, height: 50)
                                    .overlay(Image(systemName: "bookmark"))
                                Text(bm.title)
                                    .lineLimit(1)
                                    .font(.caption)
                            }
                            .onTapGesture { onSearch(bm.url) }
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
    }
}
