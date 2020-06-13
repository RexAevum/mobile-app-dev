//  PROGRAMMER: Rolans Apinis
//  PANTHERID: 6044121
//  CLASS: COP 465501 TR 5:00
//  INSTRUCTOR: Steve Luis ECS 282
//  ASSIGNMENT: Programing Assignment 3
//  DUE: Thursday 06/07/2020 //

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var game = ContactDB.shardedInstance
    var currentUser = 0
    
    var name: String = ""
    var email: String = ""
    
    var isNew = false
    var emptyContact: Contact? = nil
    
    @IBOutlet weak var secondView: UIView!
    //lables and buttons
    @IBOutlet weak var userNumber: UILabel!
    
    //text fields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get user number to display
        userNumber.text = "\((game.getContact(arrayIndex: currentUser)?.userIndex ?? -2) + 1)/\(game.getContactCount())"
        
        
        currentUser = (game.getContact(arrayIndex: currentUser)?.userIndex ?? -3)
        
        //add clear button
        nameField.clearButtonMode = .whileEditing
        emailField.clearButtonMode = .whileEditing
        
        //get name and email from DB of first user, if unable to retrieve anything
        name = game.getContact(arrayIndex: currentUser)?.name ?? ""
        email = game.getContact(arrayIndex: currentUser)?.email ?? ""
        
        //update text field
        nameField.text = name
        emailField.text = email
        
        //hide second view
        secondView.alpha = 0
        
    }
    
    
    
    /**
     Resighn first responder once user hits return
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    /*
     When user makes changes in a field, set the field text color back to normal
 */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        nameField.textColor = .black
        emailField.textColor = .black
        return true
    }
    
    /**
     Function will grab text from the text field and generate a new user using generateContact() function
 */
    @IBAction func newContact(_ sender: Any) {
        
       // name = nameField.text!
       // email = emailField.text!
        
        //----------------------------------------------------------
        isNew = true
        nameField.text = ""
        emailField.text = ""
        
        name = nameField.text!
        email = emailField.text!
        
        nameField.placeholder = "Enter your name here"
        emailField.placeholder = "Enter your email address here"
        //----------------------------------------------------------
        emptyContact = game.generateContact(name: self.name, email: self.email)
        //prevContactButton.isEnabled = false
        //nextContactButton.isEnabled = false
        
        
        
        //----------------------------------------------------------
      /*
        // old code, different functionality - once new is pressed, will add
        let check = game.addNewContact(contact: game.generateContact(name: self.name, email: self.email))
        if check == true
        {
            print("\nContact added\n")
        }
        userNumber.text = "\((game.getContact(arrayIndex: currentUser)?.userIndex ?? -2) + 1)/\(game.getContactCount())"
        */
    }
    /**
     Function will update current contact
 */
    @IBAction func updateContact(_ sender: Any) {
        var noError: Bool = false
        
        name = nameField.text!
        email = emailField.text!
        
        if (!name.contains(" "))
        {
            nameField.textColor = .red
            noError = false
        }
        
        else if (!email.contains("@"))
        {
            emailField.textColor = .red
            noError = false
        }
        else
        {
            noError = true
            nameField.textColor = .black
            emailField.textColor = .black
        }
        
        if (isNew && noError)
        {
            
            emptyContact?.name = name
            emptyContact?.email = email
            let check = game.addNewContact(contact: emptyContact!)
            if check == true
            {
                print("\nNew Contact added\n")
            }
            userNumber.text = "\((game.getContact(arrayIndex: currentUser)?.userIndex ?? -2) + 1)/\(game.getContactCount())"
            isNew = false
            //prevContactButton.isEnabled = true
            //nextContactButton.isEnabled = true
            
            
        }
        else if (noError)
        {
        
            game.updateContact(contact: Contact(name: name, email: email, userIndex: currentUser))
            
            print("\nUpdated Contact\n")
            
            userNumber.text = "\((game.getContact(arrayIndex: currentUser)?.userIndex ?? -2) + 1)/\(game.getContactCount())"
        }
    }
    @IBAction func previousContact(_ sender: Any) {
        nameField.textColor = .black
        emailField.textColor = .black
        
        if isNew
        {
            return
        }
        if currentUser == 0
        {
            //loop around
            currentUser = game.getContactCount()
        }
        currentUser -= 1
        let tempContact = game.getContact(arrayIndex: currentUser)
        
        userNumber.text = "\((tempContact?.userIndex ?? -2) + 1)/\(game.getContactCount())"
        
        name = tempContact?.name ?? ""
        email = tempContact?.email ?? ""
        
        //update text field
        nameField.text = name
        emailField.text = email
    }
    
    @IBAction func nextContact(_ sender: Any) {
       // to stop user from leaving create new user
        nameField.textColor = .black
        emailField.textColor = .black
        
        if isNew
        {
            return
        }
        if (currentUser == game.getContactCount()-1)
        {
            //loop around
            currentUser = -1
        }
        currentUser += 1
        let tempContact = game.getContact(arrayIndex: currentUser)
        
        userNumber.text = "\((tempContact?.userIndex ?? -2) + 1)/\(game.getContactCount())"
        
        name = tempContact?.name ?? ""
        email = tempContact?.email ?? ""
        
        //update text field
        nameField.text = name
        emailField.text = email
    }
    
    @IBAction func segmentButtonForSecondView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            secondView.alpha = 0
        }
        else if sender.selectedSegmentIndex == 1
        {
            secondView.alpha = 1
        }
    }
    
}

