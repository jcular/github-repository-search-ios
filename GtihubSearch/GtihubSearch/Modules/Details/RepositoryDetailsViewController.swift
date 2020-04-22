//
//  RepositoryDetailsViewController.swift
//  GtihubSearch
//
//  Created by Jure Čular on 22/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import UIKit

protocol RepositoryDetails {
    var repositoryName: String { get }
    var lastUpdateDate: String { get }
    var ownerName: String { get }
    var description: String? { get }
}

extension Repository: RepositoryDetails {
    var ownerName: String {
        return owner.name
    }
}

final class RepositoryDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
