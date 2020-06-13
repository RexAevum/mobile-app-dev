//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programing Assignment 3
//  DUE: Thursday 06/07/2020 //


import UIKit
import Foundation

// created a struct for contacts, each contact contains a name and a email string
struct Contact{
    var name: String
    var email: String?
    var userIndex: Int?
    
    mutating func updateUserIndex(index: Int) -> Void {
        self.userIndex = index
    
        
    }
}

// class for model
final class ContactDB{
    // final means class cannot be subclassed
    
    // create only one instance of the class
    static let shardedInstance = ContactDB()
    
    // add default values to DB
    var temp1 = Contact(name: "Ann Bell", email: "ab@test.edu", userIndex: 0)
    var temp2 = Contact(name: "Cain Test", email: "abell@test.edu", userIndex: 1)
    var temp3 = Contact(name: "Olly B Cool", email: "bchill@test.edu", userIndex: 2)
    
    // create an array that will hold the name and email address
    private var contactDB: [Contact] = []
    
    //variable for holding count of user ID numbers
    var lastUserNr: Int = 0
    
    //Prevent unauthorised init
    private init(){
        contactDB.append(temp1)
        contactDB.append(temp2)
        contactDB.append(temp3)
        lastUserNr = contactDB.count-1
        sortByName()
    }
    
    
    
    // add new - appends a new Contact to the DB
    /*
     Function will add a new contact to the database, if add is sucessful, resort the list
     - Parameter contact: Pass the created new user object
     - Returns: index of the new contact
     */
    func addNewContact(contact: Contact) -> Bool? {
        let lenght = contactDB.count
        //lastUserNr += 1
       
        
        contactDB.append(contact)
        sortByName()
        if (lenght == contactDB.count)
        {
            return false
        }
        
        return true
    }
    
    //added function to generate contact without passing
    func generateContact(name: String, email: String) -> Contact {
        let last = lastUserNr + 1
        return Contact (name: name, email: email, userIndex: last )
    }
    
    //update existing contact with new info
    /*
     Function will update the DB with new user information
     - Parameters:
     - contact: the new contact
     */
    func updateContact(contact: Contact) -> Void {
        // Find index number of the passed element based on the userID
        //let i = contactDB.first(where: {$0.userID == tempID})
        let x = contactDB.index(where: {$0.userIndex == contact.userIndex}) ?? -1
        
        // update collection with new contact
        if (x != -1)
        {
            //x-1 for correct index
            contactDB[x] = contact
            
            //resort list after update
            sortByName()
        }
        
        
        
    }
    
    // function to resourth the DB - usefull for later if i want to modify order
    private func sortByName (){
        contactDB.sort{
            // Ascendning = < or descending = >; lower cased due to
            $0.name.lowercased() < $1.name.lowercased()
        }
        
        //update userIndex
        var i = 0
        
        // using var con makes con unmutable and allows manipulation
        //Since i am using a struct and the structs pass by value not by referrance, unlike class that passes the refereance
        for var con in contactDB
        {
            con.updateUserIndex(index: i)
            contactDB[i] = con
            i += 1
        }
 
    }
    
    // function to return user info from DB
    /*
     Function will return the specified user
     - parameters:
     - user: User ID number
     - returns: The specified user
     */
    func getContact(arrayIndex: Int) -> Contact?{
        if (arrayIndex > contactDB.count-1)
        {
            return nil
        }
        
        return contactDB[arrayIndex]
    }
    
    //function will return total count of registerd users
    func getContactCount() -> Int {
        return contactDB.count
    }
    

}
    
    


