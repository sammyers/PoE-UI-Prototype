//
//  LoadingViewController.swift
//  PoE UI Prototype
//
//  Created by Sam Myers on 11/9/17.
//  Copyright © 2017 Sam4CORe. All rights reserved.
//

import UIKit
import Alamofire

let URL_PATH = "http://10.27.27.129:3000"

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("\(URL_PATH)/status").responseJSON { response in
            if let result = response.result.value as? [String:Any] {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "mainVC") as! ViewController
                self.present(viewController, animated: true, completion: nil)
                viewController.setState(props: result)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
