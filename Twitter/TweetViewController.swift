//
//  TweetViewController.swift
//  Twitter
//
//  Created by Troy Good on 2/10/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
  
  @IBOutlet weak var tweetTextView: UITextView!

  @IBOutlet weak var charCountLabel: UILabel!
  
  override func viewDidLoad() {
        super.viewDidLoad()
      tweetTextView.becomeFirstResponder()
      tweetTextView.delegate = self
      

        // Do any additional setup after loading the view.
    }
    
  
  
  @IBAction func cancel(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func tweet(_ sender: Any) {
    if (!tweetTextView.text.isEmpty) {
      TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {self.dismiss(animated:true, completion:nil)}, failure: { (error) in
        print("Error posting tweet \(error)")
        self.dismiss(animated: true, completion: nil)
    })
    } else {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    
    let characterLimit = 140
    
    let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
    
    charCountLabel.text = String(newText.count)
     
     return newText.count < characterLimit
    
    
  }
}
