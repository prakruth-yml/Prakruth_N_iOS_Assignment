//
//  OxfordResultsTableVC.swift
//  DEmo
//
//  Created by Prakruth Nagaraj on 16/08/19.
//  Copyright © 2019 Prakruth Nagaraj. All rights reserved.
//

import UIKit

class OxfordResultsTableVC: UITableViewController {
    
    var wordToSearch: String = "car"
    let urlString = "https://od-api.oxforddictionaries.com/api/v2"
    let appID = "701c9c97"
    let appKey = "ab5b061ec5a81e1e172b828302ee964e"
    let lang = "en-us"
    let field = "definitions"
    let strictMatch = "false"
    var urlDataTask: URLSessionDataTask?
    var defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var meaning : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("In TVC")
        networkingSetup()
        sleep(3)
        //print("TEst: ")
        print(meaning)
        if(meaning.count < 1){
            print("JNOO ")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meaning.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
        cell.textLabel?.text = meaning[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func networkingSetup(){
        
        let urlStr = "https://od-api.oxforddictionaries.com:443/api/v2/entries/\(lang)/\(self.wordToSearch)?fields=\(field)&strictMatch=\(strictMatch)"
        let url = URL(string: urlStr)
        var urlRequest = URLRequest(url: url!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(appID, forHTTPHeaderField: "app_id")
        urlRequest.addValue(appKey, forHTTPHeaderField: "app_key")
        //var temp : [String]
        
        urlDataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if let errorInCloure = error{
                print(errorInCloure as Any)
            }
            else{
                self.meaning = self.callApi(data: data!, response: response!)
            }
        })
        
        urlDataTask?.resume()
    }
    
    func callApi(data: Data?, response: URLResponse) -> [String]{
        
        if let dataItems = data{
            do{
                let jsonReturn = try JSONSerialization.jsonObject(with: dataItems, options: JSONSerialization.ReadingOptions(rawValue: 0)) as! NSDictionary
                let temp = jsonReturn["results"] as! NSArray
                let temp2 = temp[0] as! NSDictionary
                let temp3 = temp2["lexicalEntries"] as? NSArray
                let temp4 = temp3?[0] as? NSDictionary
                let temp5 = temp4?["entries"] as? NSArray
                let temp6 = temp5?[0] as? NSDictionary
                let temp7 = temp6?["senses"] as? NSArray
                let temp8 = temp7?[0] as? NSDictionary
                let temp9 = temp8?["definitions"]
                let temppp = temp9 as? NSArray
                let temp1111 = temppp![0] as? String
                meaning.append(temp1111 ?? "nil")
                let temp10 = temp8?["subsenses"] as? NSArray
                
                for item in temp10!{
                    let tempp = item as? NSDictionary
                    let x = tempp?["definitions"] as? NSArray
                    let xx = x![0] as? String
                    meaning.append(xx ?? "nil")
                }
                
                //print(meaning)
                print("done 2")
                return meaning
                
                
            }catch{
                print("Exception Caught")
            }
        }
        else{
            
        }
        return [""]
    }
    
    
    

}
