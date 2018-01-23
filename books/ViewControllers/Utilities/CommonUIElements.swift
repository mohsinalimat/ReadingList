//
//  CommonUIElements.swift
//  books
//
//  Created by Andrew Bennet on 01/04/2017.
//  Copyright © 2017 Andrew Bennet. All rights reserved.
//

import Foundation
import UIKit
import DZNEmptyDataSet

func duplicateBookAlertController(goToExistingBook: @escaping () -> (), cancel: @escaping () -> ()) -> UIAlertController {
    
    let alert = UIAlertController(title: "Book Already Added", message: "A book with the same ISBN or Google Books ID has already been added to your reading list.", preferredStyle: UIAlertControllerStyle.alert)

    // "Go To Existing Book" option - dismiss the provided ViewController (if there is one), and then simulate the book selection
    alert.addAction(UIAlertAction(title: "Go To Existing Book", style: UIAlertActionStyle.default){ _ in
        goToExistingBook()
    })
    
    // "Cancel" should just envoke the callback
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){ _ in
        cancel()
    })
    
    return alert
}

class StandardEmptyDataset {
    
    static func title(withText text: String) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [NSAttributedStringKey.font: Fonts.gillSans(ofSize: 32), NSAttributedStringKey.foregroundColor: UIColor.gray])
    }
    
    static func description(withMarkdownText markdownText: String) -> NSAttributedString {
        let bodyFont = Fonts.gillSans(forTextStyle: .title2)
        let boldFont = Fonts.gillSansSemiBold(forTextStyle: .title2)
        
        let markdown = MarkdownWriter(font: bodyFont, boldFont: boldFont)
        return markdown.write(markdownText)
    }
}
