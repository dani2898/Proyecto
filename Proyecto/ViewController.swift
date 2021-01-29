//
//  ViewController.swift
//  Proyecto
//
//  Created by Mac13 on 20/01/21.
//

import UIKit
import CoreData
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var peliculaTF: UITextField!
    @IBOutlet weak var tabla: UITableView!
    var locationManager = CLLocationManager()
    let movieManager = MovieManager()
    var recibirUsuario : String = ""
    var pelicula: String?
    var arrayParaEnviar: [String] = []
    var opiniones = [Recomendacion]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(recibirUsuario)
        
        locationManager.delegate = self
                
                //solicita el permiso del usuario
                
                // la ubicacion
    
      
    }

    @IBAction func verRecomendacionesBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "verRecomendaciones", sender: recibirUsuario)
    }
   
    @IBAction func gpsCoordenadasBtn(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()

        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           print("Se obtuvo la ubicacion")
           
           if let ubicaciones = locations.last{
               locationManager.stopUpdatingLocation()
               let latitud = ubicaciones.coordinate.latitude
               let longitud = ubicaciones.coordinate.longitude
               
            let alert = UIAlertController(title: "Coordenadas GPS", message: "Esta es tu latitud: \(latitud) y esta es tu longitud: \(longitud)", preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           }
           
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error.localizedDescription)
       }
}


extension ViewController: UITextFieldDelegate{

        func textFieldShouldReturn(_textField: UITextField)-> Bool{
            return true
        }
        
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if peliculaTF.text != ""{
                   return true
               }
               else{
                   peliculaTF.placeholder = "Escribe una pelicula"
                   return false
               }
    }
        

    @IBAction func buscarPeliculaBtn(_ sender: UIButton) {
        pelicula = peliculaTF.text!
               if pelicula != ""{
                arrayParaEnviar = [recibirUsuario, String(pelicula!)]
                   performSegue(withIdentifier: "mostrarPelicula", sender: arrayParaEnviar)
               }
               else{
                   let alert = UIAlertController(title: "Error", message: "Por favor escribe una película.", preferredStyle: UIAlertController.Style.alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                   self.present(alert, animated: true, completion: nil)
               }
               peliculaTF.text=""
    }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarPelicula"{
                
            let destino = segue.destination as! PeliculaViewController
            destino.arrayRecibir = arrayParaEnviar
            
        }
    
        if segue.identifier == "verRecomendaciones"{
            
        let destino = segue.destination as! TableViewController
        destino.recibirUsuario = recibirUsuario
        
        }
    
    
      
  
      
  }
  


}

