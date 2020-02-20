//
//  DBHelper.swift
//  Beers
//
//  Created by Sergi Rojas on 19/02/2020.
//  Copyright © 2020 Sergi Rojas. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        print(fileURL)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        //copy-paste method, almost only changed createTableString literal
        let createTableString = "CREATE TABLE IF NOT EXISTS beer(id INTEGER PRIMARY KEY,name VARCHAR(60), tagline TEXT, image_url TEXT, description TEXT, abv DOUBLE, food_pairing TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("beer table created.")
            } else {
                print("beer table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(beer: Beer)
    {
        let insertStatementString = "INSERT OR REPLACE INTO beer (id, name , tagline, image_url, description, abv, food_pairing) VALUES (?, ? , ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(beer.id))
            sqlite3_bind_text(insertStatement, 2, (beer.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (beer.tagline as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (beer.imageURL as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (beer.description as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 6, beer.abv)
            sqlite3_bind_text(insertStatement, 7, (beer.foodPairing as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read(condition: String = "") -> [Beer] {
            let queryStatementString = "SELECT * FROM beer \(condition);" //not best way to do it, I could implement a method which puts the "WHERE" clause in front and then keep formatting the query
            var queryStatement: OpaquePointer? = nil
            var beers : [Beer] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let tagline = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let imageUrl = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                    let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                    let abv = sqlite3_column_double(queryStatement, 5)
                    let foodPairing = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))

                    beers.append(Beer(id: id, name: name, tagline: tagline, imageURL: imageUrl, description: description, abv: abv, foodPairing: foodPairing))
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return beers
        }
    
        func deleteAllRows() {
            let deleteStatementStirng = "DELETE FROM beer;"
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted all.")
                } else {
                    print("Could not delete all.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            sqlite3_finalize(deleteStatement)
        }

    
}
