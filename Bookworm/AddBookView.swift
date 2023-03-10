//
//  AddBookView.swift
//  Bookworm
//
//  Created by Matheus Viana on 06/03/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)                    
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.createdIn = Date.now
                        
                        try? moc.save()
                        
                        dismiss()
                    }
                    .disabled(validateForm() == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func validateForm() -> Bool {
        if title.trimmingCharacters(in: .whitespaces).isEmpty || author.trimmingCharacters(in: .whitespaces).isEmpty || genre.trimmingCharacters(in: .whitespaces).isEmpty || review.trimmingCharacters(in: .whitespaces).isEmpty || rating < 0 {
            return false
        }
        
        return true
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
