//
//  ViewController.swift
//  PoE UI Prototype
//
//  Created by Sam Myers on 10/20/17.
//  Copyright © 2017 Sam4CORe. All rights reserved.
//

import UIKit
import Alamofire

let COLOR_INDICES = [
    "white": 5
]

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var modeSelector: UISegmentedControl!
    @IBOutlet weak var colorSelector: UISegmentedControl!

    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleSelect(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Alamofire.request("\(URL_PATH)/on", method: .post)
        case 1:
            Alamofire.request("\(URL_PATH)/off", method: .post)
        default:
            break
        }
    }

    func setState(props: [String:Any]) {
        if let lantern = props["lantern"] as? String, let color = props["color"] as? String {
            switch lantern {
            case "ON":
                modeSelector.selectedSegmentIndex = 0
            case "OFF":
                modeSelector.selectedSegmentIndex = 1
            default:
                break
            }
        }
    }
}

