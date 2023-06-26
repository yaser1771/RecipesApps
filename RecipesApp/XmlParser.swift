//
//  XmlParser.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//

import Foundation
import SwiftUI
import Combine

struct XmlModel: Identifiable {
    let id = UUID()
    var recipetype: String
}

//XML parser
class XmlParser: XMLParser {
    var itemList: [String] = []

    override init(data: Data) {
        super.init(data: data)
        self.delegate = self
    }
}

extension XmlParser: XMLParserDelegate {
    
    // Called when opening tag (`<elementName>`) is found
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {

        switch elementName {
        case "recipemodel":
            let recipe = XmlModel(recipetype: attributeDict["recipetype"] ?? "")
            itemList.append(recipe.recipetype)
        default: break
        }
    }
    
    // Called when closing tag (`</elementName>`) is found
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //...
    }
    
    // Called when a character sequence is found
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //...
    }
    
    // Called when a CDATA block is found
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        guard String(data: CDATABlock, encoding: .utf8) != nil else {
            print("CDATA contains non-textual data, ignored")
            return
        }
    }
}
