//
//  StoryViewController.swift
//  PLOSAT
//
//  Created by Gabriel Gazal on 25/11/19.
//  Copyright © 2019 OGrupoMaisBonitoDaCidade. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    @IBOutlet weak var imagemHistoria: UIImageView!
    @IBOutlet weak var HistoriaTitulo: UILabel!
    @IBOutlet weak var HistoriaDescricao: UITextView!
    @IBOutlet weak var textViewDica: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.instance.shufle()
        Model.instance.game.plosat = Plosat(personagem: Model.instance.personagem.randomElement()!, lugar: Model.instance.lugar.randomElement()!, objeto: Model.instance.objeto.randomElement()!, situacao: Model.instance.situacao.randomElement()!, acao: Model.instance.acao.randomElement()!)
        Model.instance.game.tema = Model.instance.tema.randomElement()
        textViewDica.text = "\(getNAmes()) vocês foram  vistos na cena do crime e um de vocês é culpado."
        
        
        for player in Model.instance.game.players{
            let newPlosat = Plosat.init(personagem: "", lugar: "", objeto: "", situacao:  "", acao: "")
            let n = Int.random(in: 0 ... 4)
            var g = Int.random(in: 0 ... 4)
            
            while (n == g){
                g = Int.random(in: 0 ... 4)
            }
            newPlosat.card[n] = [Model.instance.game.plosat.card[n][Int.random(in: 0...0)]]
            newPlosat.card[g] = [Model.instance.game.plosat.card[g][Int.random(in: 0...0)]]
            
            player.plosat = newPlosat
            player.visoes = 0
        }
        Model.instance.viuModal = false
        HistoriaTitulo.text = Model.instance.game.tema.titulo
        HistoriaDescricao.text = Model.instance.game.tema.descricao
        Model.instance.game.declareGuilty()
        
        // Do any additional setup after loading the view.
    }
    
    func getNAmes() -> String{
        var nomes = ""
        for player in Model.instance.game.players{
            nomes = "\(player.name),"
        }
        return nomes
    }
    
    
    @IBAction func next(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .button)

    }
}
