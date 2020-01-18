import UIKit

class ViewController: UIViewController {
    
    let labs = ["Basic Anchors",
                "Safe Area Guide",
                "Layout Margin",
                "Spacer Views",
                "Readable Content Guide"]
    
    let cellId = "cellId"
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        view = tableView
    }
}

extension ViewController: UITableViewDelegate {
    // optional...
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = labs[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labs.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}















/*
 class ViewController: UITableViewController {
     
     let labs = ["Basic Anchors",
                 "Safe Area Guide",
                 "Layout Margin",
                 "Spacer Views",
                 "Readable Content Guide"]
     
     let cellId = "cellId"
     
     override func viewDidLoad() {
         super.viewDidLoad()
         setupViews()
     }
     
     func setupViews() {
         navigationItem.title = "Anchors"
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
     }
     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
         
         cell.textLabel?.text = labs[indexPath.row]
         cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
         
         return cell
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return labs.count
     }
     
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
     }
 }

 */
