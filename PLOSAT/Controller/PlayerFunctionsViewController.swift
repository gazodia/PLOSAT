//
//  PlayerFunctionsViewController.swift
//  PLOSAT
//
//  Created by Gabriel Gazal on 25/11/19.
//  Copyright © 2019 OGrupoMaisBonitoDaCidade. All rights reserved.
//

import UIKit

class PlayerFunctionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var PlayersTableView: UITableView!
    @IBOutlet weak var nextPageButton: DesignableButton!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Model.instance.game.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailTableViewCell
        
        cell.playerImage.image = Model.instance.game.players[indexPath.section].foto
        cell.playerName.text = Model.instance.game.players[indexPath.section].name
        if Model.instance.game.players[indexPath.section].visoes <= 1{
            cell.iconLocker.image = UIImage(named: "eye")
        }else{
            cell.iconLocker.image = UIImage(named: "locker")
            
        }
        //cell.contagem.text = String(Model.instance.game.players[indexPath.section].visoes)/
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadData()
        Model.instance.game.players[indexPath.section].visoes += 1
        if Model.instance.game.players[indexPath.section].visoes <= 1{
            if let vc = storyboard?.instantiateViewController(identifier: "vcDetalhe") as? PapeisViewController {
                vc.player = Model.instance.game.players[indexPath.section]
                DispatchQueue.main.async {
                    self.present(vc, animated: true)
                    
                }
                
            }
        }
        
        //        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        PlayersTableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        PlayersTableView.reloadData()
    }
    
    @IBAction func next(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)

    }
    
    
    
}
