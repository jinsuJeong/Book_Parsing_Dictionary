//
//  ViewController.swift
//  Book_Parsing_Dictionary
//
//  Created by D7703_18 on 2018. 10. 8..
//  Copyright © 2018년 201550057. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    var item:[String:String] = [:]  // item[key] => value
    var elements:[[String:String]] = []
    var currentElement = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self
        
                if let path = Bundle.main.url(forResource: "book", withExtension: "xml") {
                    if let parser = XMLParser(contentsOf: path) {
                        parser.delegate = self
        
                        if parser.parse() {
                            print("parse succeed!")
                            print(elements)
                        } else {
                            print("parse failed!")
                        }
                    }
                } else {
                    print("xml file not found")
                }
    }
    
    // UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        
        let myItem = elements[indexPath.row]
        
        cell.textLabel?.text = myItem["title"]
        cell.detailTextLabel?.text = myItem["author"]
        
        return cell
    }
    
    // XMLParseDelegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        
        print("currentElement = \(elementName)")
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        print("data = \(data)")
        if !data.isEmpty {
            item[currentElement] = data  // item[key] => value  =>  [key:value]
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
    }
}



