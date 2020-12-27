//
//  SqliteDataProvider.swift
//  AddmissionDemoRam
//
//  Created by Rambali on 25/12/20.
//  Copyright © 2020 Ram Vinay. All rights reserved.
//
// lib doc : https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#connecting-to-a-database

import Foundation
import SQLite

class RVSqliteDataProvider {
    
    fileprivate var db : Connection!
    fileprivate let DEBUG_TAG = "RVSqliteDataProvider"
    fileprivate let DB_NAME = "com.app.a24DemoRam"
    
    //MARK:- Table name
    fileprivate let homeresponse = Table("Home")
    fileprivate let categoriesTable = Table("categories")
    fileprivate let productTable = Table("products")
    
    //MARK:- Expression key name
    fileprivate let id = Expression<Int64>("id")
    fileprivate let userId = Expression<String>("user_id")
    fileprivate let email = Expression<String>("email")
    fileprivate let data = Expression<String>("data")
    fileprivate let categoriesId = Expression<String>("categoriesId")
    fileprivate let dataBlob = Expression<Data>("dataBlob") // photo / video
    
    static let shared = RVSqliteDataProvider()
    private init(){}
    
    func initDatabaes() {
        self.connectToDB()
        self.createTables()
    }
    
}

extension RVSqliteDataProvider {
   
    //save encoded data
    func saveHomeResponseData(userEmail : String,  userId : String, data : Data ) -> Int64 {
        do {
            let rowid = try db.run(
                homeresponse.insert(or: .replace,
                                    self.email <- userEmail,
                                    self.userId <- userId,
                                    self.dataBlob <- data
            ))
            
            debugPrint("Home response inserted id: \(rowid)")
            return rowid
        } catch {
            debugPrint("Home insertion failed: \(error)")
            return 0
        }
    }
    
    
    //retrive saved encoded data
    func getHomeResponseData(userEmail: String, userId: String) -> Data! {
        do {
            let query = homeresponse
                .filter(email == userEmail && userId  == userId)
            for data in try db.prepare(query) {
                return data[dataBlob]
            }
        } catch {
            debugPrint("SQLITE DATA PROVIDER : ",error.localizedDescription)
        }
        return nil
    }
    
    func deleteHomeData(userEmail: String, userId: String) {
        do {
            if try db.run(homeresponse.delete()) > 0 {
                debugPrint("deleted home data.")
            } else {
                debugPrint("deletion failed as there is no such record maching the query")
            }
        } catch {
            debugPrint("delete failed: \(error)")
        }
    }
    
    //save encoded data
    func saveCategoriesResponseData(userEmail : String,  userId : String, data : Data ) -> Int64 {
        do {
            let rowid = try db.run(
                categoriesTable.insert(or: .replace,
                                    self.email <- userEmail,
                                    self.userId <- userId,
                                    self.dataBlob <- data
            ))
            
            debugPrint("categories response inserted id: \(rowid)")
            return rowid
        } catch {
            debugPrint("categories insertion failed: \(error)")
            return 0
        }
    }
    
    //retrive saved encoded data
    func getCategoriesResponseData(userEmail: String, userId: String) -> Data! {
        do {
            let query = categoriesTable
                .filter(email == userEmail && userId  == userId)
            for data in try db.prepare(query) {
                return data[dataBlob]
            }
        } catch {
            debugPrint("SQLITE DATA PROVIDER : ",error.localizedDescription)
        }
        return nil
    }
    
    func deleteCategoriesData(userEmail: String, userId: String) {
        do {
            if try db.run(categoriesTable.delete()) > 0 {
                debugPrint("deleted categries data.")
            } else {
                debugPrint("deletion failed as there is no such record maching the query")
            }
        } catch {
            debugPrint("delete failed: \(error)")
        }
    }
    
    //save encoded data
    func saveProductResponseData(userEmail : String,  userId : String, categorieId:String ,data : Data ) -> Int64 {
        do {
            let rowid = try db.run(
                productTable.insert(or: .replace,
                                    self.email <- userEmail,
                                    self.userId <- userId,
                                    self.dataBlob <- data,
                                    self.categoriesId <- categorieId
            ))
            
            debugPrint("Product response inserted id: \(rowid)")
            return rowid
        } catch {
            debugPrint("Product insertion failed: \(error)")
            return 0
        }
    }
    
    //retrive saved encoded data
    func getProductResponseData(userEmail: String, userId: String, categorieId:String) -> Data! {
        do {
            let query = productTable
                .filter(email == userEmail && self.userId  == userId && categoriesId == categorieId)
            for data in try db.prepare(query) {
                return data[dataBlob]
            }
        } catch {
            debugPrint("SQLITE DATA PROVIDER : ",error.localizedDescription)
        }
        return nil
    }
    
    func deleteProductData(userEmail: String, userId: String, categoriesId:String) {
        do {
            let productDelete = productTable.filter( email == userEmail && userId  == userId && categoriesId == categoriesId )

            if try db.run(productDelete.delete()) > 0 {
                debugPrint("deleted product data.")
            } else {
                debugPrint("deletion failed as there is no such record maching the query")
            }
        } catch {
            debugPrint("delete failed: \(error)")
        }
    }
    
}

extension RVSqliteDataProvider {
    
    fileprivate  func connectToDB() {
        do {
            let path = getPath()
            //this will crete database if it not exist other wise will retun existing database
            db = try Connection("\(path)/\(DB_NAME)")
            debugPrint("SQLITE DATA PROVIDER : database created successfully")
        } catch {
            debugPrint("SQLITE DATA PROVIDER : ",error.localizedDescription)
        }
    }
    
    func createDatabase() {
        
        let directory:String = getPath()
        let dBpath = (directory as NSString).appendingPathComponent(DB_NAME)
        debugPrint("Database Path : ",dBpath)
        
        if (FileManager.default.fileExists(atPath: dBpath)) {
            debugPrint("SQLITE DATA PROVIDER : Database already exists")
        } else {
            let pathfrom:String = (Bundle.main.resourcePath! as NSString).appendingPathComponent(DB_NAME)
            
            var success:Bool
            do {
                try FileManager.default.copyItem(atPath: pathfrom, toPath: dBpath)
                success = true
            } catch _ {
                success = false
            }
            
            if !success {
                debugPrint("SQLITE DATA PROVIDER : Failed to create database")
            } else {
                debugPrint("SQLITE DATA PROVIDER : Successfull created new database")
            }
        }
    }
    
    private func createTables() {
        do {
            
            try db.run(homeresponse.create(ifNotExists: true) { t in     // CREATE TABLE "Home" (
                // t.column(id, primaryKey: .autoincrement ) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(email)     // "email" TEXT,
                t.column(dataBlob)  //     "data" TEXT
                t.column(userId)
                t.primaryKey(email, userId)
            })
            
            try db.run(categoriesTable.create(ifNotExists: true) { t in     // CREATE TABLE "Categories" (
                // t.column(id, primaryKey: .autoincrement ) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(email)     // "email" TEXT,
                t.column(dataBlob)  // "data" TEXT
                t.column(userId)
                t.primaryKey(email, userId)
            })

            try db.run(productTable.create(ifNotExists: true) { t in     // CREATE TABLE "Product" (
                // t.column(id, primaryKey: .autoincrement ) //     "id" INTEGER PRIMARY KEY NOT NULL,
                t.column(email)     // "email" TEXT,
                t.column(dataBlob)  // "data" TEXT
                t.column(userId)
                t.column(categoriesId)
                t.primaryKey(email, userId, categoriesId)
            })

        } catch {
            debugPrint("SQLITE DATA PROVIDER : ",error.localizedDescription)
        }
    }
    
    
    func deleteAllTableFromLocalDataBase(userEmail: String, userId: String) {
        
        //Delete home table
        self.deleteCategoriesData(userEmail: userEmail, userId: userId)
        
        //Delete categories table
        self.deleteCategoriesData(userEmail: userEmail, userId: userId)
        
        //delete product table
        self.deleteAllProductData(userEmail: userEmail, userId: userId)
                
    }
    
    fileprivate func deleteAllProductData(userEmail: String, userId: String) {
        
        do {
            let productDelete = productTable.filter( email == userEmail && userId  == userId )

            if try db.run(productDelete.delete()) > 0 {
                debugPrint("deleted all product data.")
            } else {
                debugPrint("deletion failed as there is no such record maching the query")
            }
        } catch {
            debugPrint("delete failed: \(error)")
        }
        
    }
    
}

//MARK:- Helper methods
extension RVSqliteDataProvider {
    
    func getPath()-> String {
        let path:Array = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let directory:String = path[0]
        debugPrint("DATABASE PATH : \(directory)")
        return directory
    }
    
}


//to support UIImage as type in table
extension UIImage: Value {
    
    public class var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    
    public class func fromDatatypeValue(_ blobValue: Blob) -> UIImage {
        return UIImage(data: Data.fromDatatypeValue(blobValue))!
    }
    
    public var datatypeValue: Blob {
        return self.pngData()!.datatypeValue
    }
    
}
