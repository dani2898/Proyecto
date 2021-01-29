//
//  PeliculaViewController.swift
//  Proyecto
//
//  Created by Jessica Villa on 26/01/21.
//

import UIKit

class PeliculaViewController: UIViewController {
    var movieManager = MovieManager()
    var idPelicula: Int = 0
    var nombrePelicula: String = ""
    var arrayRecibir: [String] = []
    var posterPath: String = ""
    @IBOutlet weak var peliculaImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var overviewTV: UITextView!
    @IBOutlet weak var calificacionLabel: UILabel!
    @IBOutlet weak var recomendarBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieManager.delegado = self
        print(arrayRecibir[1])
        movieManager.fetchMovie(nombrePelicula: arrayRecibir[1])
    }
    
    @IBAction func recomendarPeliculaBtn(_ sender: UIButton) {
        arrayRecibir = [arrayRecibir[0], String(idPelicula), posterPath, nombrePelicula]
        performSegue(withIdentifier: "recomendarPelicula", sender: arrayRecibir)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "recomendarPelicula"{
                  
              let destino = segue.destination as! RecomendacionViewController
              destino.recibirDatosPelicula = arrayRecibir
              
          }
        
    
        
    }
    
}

extension PeliculaViewController: movieManagerDelegate{
    
    func huboError(cualError: Error){
        print(cualError)
        
        DispatchQueue.main.sync{
            let alert = UIAlertController(title: "Error", message: "Error en la ciudad, revise que esté escrito correctamente.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func actualizarMovie(movie: MovieModelo) {
        
        DispatchQueue.main.async { [self] in
            print("Pelicula")
            let imageUrlString = movie.posterPathPelicula

            let imageUrl = URL(string: imageUrlString)!

            let imageData = try! Data(contentsOf: imageUrl)
            posterPath = imageUrlString
            self.idPelicula = movie.idPelicula
            self.peliculaImageView.image = UIImage(data: imageData)
            nombrePelicula = movie.titlePelicula
            self.tituloLabel.text = String(movie.titlePelicula)
            self.overviewTV.text = String(movie.overviewPelicula)
            self.calificacionLabel.text = String(movie.voteAveragePelicula)
            }
        
        
    }
    
}

    

