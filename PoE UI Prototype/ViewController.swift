//
//  ViewController.swift
//  PoE UI Prototype
//
//  Created by Sam Myers on 10/20/17.
//  Copyright © 2017 Sam4CORe. All rights reserved.
//

import UIKit
import Alamofire

let lanternModes = ["off", "on", "pulse", "sensory"]
let lightModes = ["off", "on", "pulse", "mirror"]

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var lanternModeSelector: UISegmentedControl!
    @IBOutlet weak var lightModeSelector: UISegmentedControl!

    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getState() -> Parameters {
        let state: Parameters = [
            "lanternMode": lanternModes[lanternModeSelector.selectedSegmentIndex],
            "lightMode": lightModes[lightModeSelector.selectedSegmentIndex],
            "pulseSpeed": 1
        ]
        return state
    }
    
    func updateLantern() {
        Alamofire.request("\(URL_PATH)/update", method: .post, parameters: getState(), encoding: JSONEncoding.default).responseJSON { response in
            if let result = response.result.value as? [String:Any] {
                self.setState(props: result)
            }
        }
    }

    @IBAction func handleLanternSelect() {
        updateLantern()
    }
    
    @IBAction func handleLightSelect() {
        updateLantern()
    }
    
    func setState(props: [String:Any]) {
        if let lantern = props["lanternMode"] as? String, let light = props["lightMode"] as? String {
            let lanternMode = lanternModes.index(of: lantern)!
            let lightMode = lightModes.index(of: light)!
            lanternModeSelector.selectedSegmentIndex = lanternMode
            lightModeSelector.selectedSegmentIndex = lightMode
            if lanternMode == 3 {
                lightModeSelector.setEnabled(false, forSegmentAt: 0)
                lightModeSelector.setEnabled(false, forSegmentAt: 1)
                lightModeSelector.setEnabled(false, forSegmentAt: 2)
            } else {
                lightModeSelector.setEnabled(true, forSegmentAt: 0)
                lightModeSelector.setEnabled(true, forSegmentAt: 1)
                lightModeSelector.setEnabled(true, forSegmentAt: 2)
            }
        }
    }
}
