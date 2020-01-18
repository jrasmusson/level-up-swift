/*
   ___         _               _   ___      _               _
  | _ \_ _ ___| |_ ___  __ ___| | |   \ ___| |___ __ _ __ _| |_ ___
  |  _/ '_/ _ \  _/ _ \/ _/ _ \ | | |) / -_) / -_) _` / _` |  _/ -_)
  |_| |_| \___/\__\___/\__\___/_| |___/\___|_\___\__, \__,_|\__\___|
                                                 |___/
                     ___      _   _
                    | _ \__ _| |_| |_ ___ _ _ _ _
                    |  _/ _` |  _|  _/ -_) '_| ' \
                    |_| \__,_|\__|\__\___|_| |_||_|

 */

// What is?

// Core pattern in iOS used extensively in UIKit. If you have every built an app in iOS using a UITableViewController, or  UITextField, you have already used it.

// What the delegate protocol is so good at is it allows an object to communicate back to its owner, without caring or knowing anything it. That way many differnt types of clients can use it, without it having to know anything about them.

// For example take UITextField

// Demo and explain
// Then fail until you register yourself as a delegate - core of the pattern
/*
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Hello"
        
        textField.delegate = self // the key!
        
        view.addSubview(textField)
        
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Did begin editing")
    }
}
*/




/*
protocol UITableViewDataSource : NSObjectProtocol {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func numberOfSections(in tableView: UITableView) -> Int
}

class UITableView : UIScrollView, NSCoding, UIDataSourceTranslating {
    weak open var dataSource: UITableViewDataSource?
}
*/

// How does it work?
