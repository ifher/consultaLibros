//
//  ViewController.swift
//  consultaLibros
//
//  Created by Fer on 15/1/16.
//  Copyright © 2016 Fer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ISBN: UITextField!
    @IBOutlet weak var textResponse: UITextView!
    
    func consultaLibro() {
        let isbnTexto: String = ISBN.text!
        textResponse.text = ""
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbnTexto
        let url = NSURL(string: urls)
        let datos: NSData? = NSData(contentsOfURL: url!)
        
        if datos != nil {
            let texto = NSString (data: datos!, encoding: NSUTF8StringEncoding)
            textResponse.text = String(texto)
        }else{
            let alertController = UIAlertController(title: "Error", message: "Ha habido un problema conectando con el servidor. Revisa tu conexión a internet y vuelve a intentarlo.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.ISBN.delegate = self
        
        //ponemos un ejemplo en la caja para que se pueda comprobar
        ISBN.text = "978-84-376-0494-7"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        consultaLibro()
        return false
    }


}

