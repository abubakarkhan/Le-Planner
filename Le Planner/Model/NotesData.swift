//
//  NotesData.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import Foundation

class NotesData {
    
    private var notesList : Array<Note> = []
    
    static let instance = NotesData()
    
    private init(){
        notesList.append(Note(title: "Lorem Ipsum", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."))
        
        notesList.append(Note(title: "Groceries", body: "Pick up egss,milk and break."))
        
        notesList.append(Note(title: "Lectures and Labs", body: "Monday, Wednesday and Friday "))
        
        notesList.append(Note(title: "Lorem Ipsum", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."))
        
    }
    
    func getNotesList() -> Array<Note> {
        return notesList
    }
    
    func addNote(note: Note){
        notesList.append(note)
    }
    
    func deleteNote(index: Int) {
        notesList.remove(at: index)
    }
    
}
