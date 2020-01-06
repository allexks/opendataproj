//
//  PeriodsViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit

class PeriodsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Constants
    
    private let cellReuseID = "periodCell"
    private let segueID = "periodDetail"
    
    // MARK: - Properties
    
    var pmType: PMType!
    
    private var periods: [PeriodViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        updatePeriodViewModels()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == segueID, let nextVC = segue.destination as? PeriodDetailViewController else {
            fatalError("stiga e")
        }
        guard let vm = sender as? PeriodViewModel else {
            fatalError("veche ne predavame viewmomdela kato sender?")
        }
        nextVC.periodViewModel = vm
    }
}

// MARK: - Helpers

private extension PeriodsViewController {
    func updatePeriodViewModels() {
        periods = DataRepository.shared.fetchAllPeriodViewModels(forPmType: pmType)
    }
    
    func viewModelForIndexPath(_ indexPath: IndexPath) -> PeriodViewModel {
        return periods[indexPath.row]
    }
}

// MARK: - Table View Data Source
extension PeriodsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return periods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        let vm = viewModelForIndexPath(indexPath)
        cell.textLabel?.text = vm.asString
        return cell
    }
}

// MARK: - Table View Delegate

extension PeriodsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueID, sender: viewModelForIndexPath(indexPath))
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude // remove empty cell lines
    }
}
