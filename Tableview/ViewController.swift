//
//  ViewController.swift
//  Tableview
//
//  Created by Max on 05.03.21.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconbackgroundcolor: UIColor
    let handler: (() -> Void)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    private let tableView:UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingViewCell.self, forCellReuseIdentifier: SettingViewCell.identifier)
        return table
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUi()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }

    func configureUi(){
        models.append(Section(title: "general",
                              options: [SettingsOption(title: "Wifi", icon: UIImage(systemName: "house"), iconbackgroundcolor: .systemBlue){print("Tapped 1") },
                                        SettingsOption(title: "Bluetooth", icon: UIImage(systemName: "bluetooth"), iconbackgroundcolor: .systemBlue){ },
                                        SettingsOption(title: "Airplane Mode", icon: UIImage(systemName: "airplane"), iconbackgroundcolor: .systemBlue){ },
                                        SettingsOption(title: "cloud", icon: UIImage(systemName: "cloud"), iconbackgroundcolor: .systemBlue){ },
                                        SettingsOption(title: "Wifi", icon: UIImage(systemName: "house"), iconbackgroundcolor: .systemBlue){ },
                                        SettingsOption(title: "Wifi", icon: UIImage(systemName: "house"), iconbackgroundcolor: .systemBlue){ }]))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingViewCell.identifier,
                                                 for: indexPath) as? SettingViewCell else {
            return UITableViewCell()
        }
        
        cell.configureUI(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
}

