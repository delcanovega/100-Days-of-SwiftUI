//
//  ContentView.swift
//  Bookworm
//
//  Created by Paul Hudson on 16/11/2023.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]

    @State private var showingAddScreen = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating == 1 ? Color.red : Color.primary)

                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .shadow(color: book.rating == 1 ? Color.red : Color.primary, radius: book.rating == 1 ? 10 : 0)
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }

    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let badExample = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "Terrible experience.", rating: 1)
        container.mainContext.insert(badExample)
        let goodExample = Book(title: "El Último Deseo", author: "Andrzej Sapkowski", genre: "Fantasy", review: "Pretty good.", rating: 4)
        container.mainContext.insert(goodExample)

        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }}
