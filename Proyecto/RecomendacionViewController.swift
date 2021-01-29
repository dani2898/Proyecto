//
//  RecomendacionViewController.swift
//  Proyecto
//
//  Created by Jessica Villa on 27/01/21.
//

import UIKit
import CoreData

class RecomendacionViewController: UIViewController {
    @IBOutlet weak var posterPeliculaImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UITextView!
    var recibirDatosPelicula: [String] = []
    var usuario: String = ""
    var opiniones = [Recomendacion]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageUrlString = recibirDatosPelicula[2]

        let imageUrl = URL(string: imageUrlString)!

        let imageData = try! Data(contentsOf: imageUrl)
        posterPeliculaImageView.image = UIImage(data: imageData)
        print(recibirDatosPelicula)
    }
    

    @IBAction func publicarBtn(_ sender: Any) {
        let newOpinion = Recomendacion(context: self.context)
        newOpinion.idPelicula = Int64(recibirDatosPelicula[1])!
        newOpinion.nombrePelicula = recibirDatosPelicula[3]
        newOpinion.opinion = reviewLabel.text
        newOpinion.username = recibirDatosPelicula[0]
        newOpinion.poster = recibirDatosPelicula[2]
        
        self.guardarRecomendacion()
        
        
        usuario = recibirDatosPelicula[0]
        performSegue(withIdentifier: "regresaPrincipal", sender: usuario)
        
    }
    
    func guardarRecomendacion(){
           do {
               try context.save()
               print("Se guardo correctamente")
               
           }catch let error as NSError{
               print("Error al guardar en la base de datos \(error.localizedDescription)")
           }
           
       }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "regresaPrincipal"{
                  
              let destino = segue.destination as! ViewController
              destino.recibirUsuario = usuario
              
          
}
    }
}
